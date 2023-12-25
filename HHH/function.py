import firebase_admin
from firebase_admin import credentials, firestore, storage
import os
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
# import threading
# from threading import Lock
# from queue import Queue

# import multiprocessing

# define dirs
PATH = os.getcwd()
output_saved_PATH = f'{PATH}/hairline/outputs'

# 파일의 크기가 안정화될 때까지 기다린 후에 업로드를 시도
class MyHandler(FileSystemEventHandler):
    def on_created(self, event):
        if event.src_path.endswith(".png"):
            print(f"{event.src_path} has been created.")
            self.wait_until_file_is_written(event.src_path)
            self.upload_to_firebase(event.src_path)

    def wait_until_file_is_written(self, file_path, timeout=10):
        """ 파일이 완전히 쓰여질 때까지 기다립니다. """
        total_wait_time = 0
        previous_size = -1
        current_size = os.path.getsize(file_path)

        while previous_size != current_size:
            if total_wait_time >= timeout:  # 타임아웃 설정
                print("Timeout waiting for file to be written")
                return
            previous_size = current_size
            time.sleep(1)  # 1초 대기
            current_size = os.path.getsize(file_path)
            total_wait_time += 1

        print("File writing completed.")

    def upload_to_firebase(self, file_path):
        """ Firebase Storage에 파일을 업로드합니다. """
        bucket = storage.bucket()
        new_blob = bucket.blob('user1/Hairline/result/source_target.png')
        try:
            new_blob.upload_from_filename(file_path)
            print('File processed and uploaded')
        except Exception as e:
            print(f'Error uploading file: {e}')
    
def start_monitoring(path):
    # Create the directory if it does not exist
    os.makedirs(path, exist_ok=True)
    
    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, path, recursive=False)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()   


# class GPUManger:
#     def __init__(self, temp_dir):
#         self.available_gpus = ['cuda:0', 'cuda:1']  # 사용 가능한 GPU 목록
#         self.task_queue = Queue()  # 작업 대기열
#         self.gpu_status = {gpu: True for gpu in self.available_gpus}  # GPU 사용 가능 여부
#         self.lock = Lock()
#         self.temp_dir = temp_dir
#         self.running = True

#     def assign_task_to_gpu(self, task, callback):
#         with self.lock:
#             for gpu in self.available_gpus:
#                 if self.gpu_status[gpu]:
#                     print(f"Assigning task to {gpu}")
#                     self.start_task_on_gpu(task, gpu, callback)
#                     return
#             print("All GPUs busy, adding task to queue")
#             self.task_queue.put((task, callback))

#     def start_task_on_gpu(self, task, gpu, callback):
#         print(f"Attempting to start task on GPU {gpu}")
#         with self.lock:
#             self.gpu_status[gpu] = False

#         # try:
#         #     task_thread = threading.Thread(target=self._run_task, args=(task, gpu, callback))
#         #     task_thread.start()
#         #     print(f"Thread started for task on {gpu}")  # 스레드 시작 로그
#         # except Exception as e:
#         #     print(f"Error starting thread for task on {gpu}: {e}")  # 에러 로그
#         def process_function():
#             print("Process function called")
#             try:
#                 result = task(gpu, self.lock)
#                 callback(result)
#             except Exception as e:
#                 print(f"Error in process function: {e}")
#             finally:
#                 with self.lock:
#                     self.gpu_status[gpu] = True

#         process = multiprocessing.Process(target=process_function)
#         process.start()
    
#     def check_and_assign_tasks(self):
#         while self.running:
#             with self.lock:
#                 for gpu in self.available_gpus:
#                     if self.gpu_status[gpu] and not self.task_queue.empty():
#                         print(f"GPU {gpu} is available, assigning task from queue")
#                         task, callback = self.task_queue.get()
#                         self.start_task_on_gpu(task, gpu, callback)
#             time.sleep(0.1)  # 효율적인 대기를 위한 짧은 슬립

#     def _run_task(self, task, gpu, callback):
#         # Run the task
#         print(f"Starting task on {gpu}")
        
#         try:
#             result = task(gpu, self.lock)
#             callback(result)
#             print(f"Task on {gpu} completed, result: {result}")
#         except Exception as e:
#             print(f"Error in _run_task on GPU {gpu}: {e}")  # 예외 발생 로그
#         finally:
#             with self.lock:
#                 self.gpu_status[gpu] = True
#                 print(f"GPU {gpu} set to available")
#             initialize_file_queue(self.temp_dir)
        
    
#     def stop(self):
#         self.running = False
            
# def update_firestore_with_result(result, date, field, filename):
#     db = firestore.client()
#     res_doc_ref = db.collection('scalp_ml').document(date)
#     result['image'] = filename
#     field_data = {field: result}

#     # Update Firestore with the result
#     res_doc_ref.set(field_data, merge=True)