from flask import Flask, request
from scalp_clf import classify_scalp  
from is_scalp import is_scalp_image
from hairline import hairline_pred_run 
import firebase_admin
from firebase_admin import credentials, firestore, storage
import os
from function import start_monitoring
import threading
import time #추가

from pd_recomm import product_recommender

# define dirs
PATH = os.getcwd()
input_data_dir = f'{PATH}/scalp/input/unknown'
model_saved_PATH = f'{PATH}/scalp/model_pt'
temp_dir = f'{PATH}/scalp/temp'
prediction_json_dir = f'{PATH}/scalp/user_history/prediction_result/'
user_history_dir = f'{PATH}/scalp/user_history/images/'
output_saved_PATH = f'{PATH}/hairline/outputs/'

# firebase initialize
cred = credentials.Certificate(f'{PATH}/functions/{certificate}.json')
firebase_admin.initialize_app(cred, {
    'storageBucket' : "{bucket}.appspot.com"
})
db = firestore.client()

app = Flask(__name__)

@app.route('/process-scalp-image', methods=['POST'])
def process_scalp_image():
    # JSON 데이터 추출
    data = request.json
    filename = data['filename']
    
    # Extract field, date from filename
    field, date = os.path.basename(filename).split('.')[0].split('_')
    field = field.capitalize()
    
    # Firebase 스토리지에서 파일 다운로드
    bucket = storage.bucket()
    blob = bucket.blob(filename)
    download_path = os.path.join(input_data_dir, os.path.basename(filename))
    blob.download_to_filename(download_path)

    # 바로 이미지가 두피 이미지인지 확인하는 모델 실행하고
    is_scalp_output = is_scalp_image(input_data_dir, model_saved_PATH, temp_dir)
    # Create document data with filename and is_scalp_result
    # Send is_scalp_output to Firebase Firestore
    doc_ref = db.collection('upload_events').document(os.path.basename(filename).split('.')[0])
    doc_ref.set({'success': is_scalp_output['success']})
    
    if is_scalp_output['success']:
        
        # GPU 할당 로직
        if "top" in filename or "left" in filename:
            gpu_id = "cuda:0"
        elif "back" in filename or "right" in filename:
            gpu_id = "cuda:1"
        else:
            gpu_id = "cuda:0"  # 기본값 설정

        scalp_clf_output= classify_scalp(temp_dir+'/true', model_saved_PATH, prediction_json_dir, user_history_dir, gpu_id)
        
        scalp_clf_output['image'] = filename
        
        # Prepare the data structure for Firestore
        res_doc_ref = db.collection('scalp_ml').document(date)
        field_data = {field: scalp_clf_output}

            # Update or create the document with new field data
        res_doc_ref.set(field_data, merge=True)
    return 'Scalp image processed', 200

# 글로벌 변수로 함수 실행 여부를 추적
hairline_pred_run_executed = False

@app.route('/process-hairline-image', methods=['POST'])
def process_hairline_image():
    global hairline_pred_run_executed

    # 이미 실행된 경우, 추가 실행 방지
    if hairline_pred_run_executed:
        return 'Hairline model has already been run', 200
    
    # JSON 데이터 추출
    data = request.json
    filename = data.get('filename')
    
    # Firebase 스토리지의 기본 버킷 인스턴스 가져오기
    bucket = storage.bucket()
    
    # Firebase 스토리지에서 파일 다운로드
    blob = bucket.blob(filename)
    download_path = os.path.join(f'{PATH}/hairline/ffhq_image/', 'source.png')
    blob.download_to_filename(download_path)
    
    # Run hairline main.py
    print(f"Start Hairline Model with {download_path}")
    hairline_pred_run('source.png') 
    
    # 함수 실행 상태 업데이트
    hairline_pred_run_executed = True

    print(f"File uploaded to Firebase Storage.") #추가

    print(f"File deleted successfully.") #추가
    
    
    return 'File processed', 200

@app.route('/process-recommender', methods=['POST'])
def process_survey_recommender():
    # Firestore에서 'Survey'로 시작하는 최신 문서 가져오기
    upload_events_ref = db.collection('upload_events')
    query = upload_events_ref.order_by('timestamp', direction=firestore.Query.DESCENDING).limit(1)
    docs = query.stream()

    for doc in docs:
        if doc.id.startswith('Survey'):
            data = doc.to_dict()
            userid = data.get('userid')
            timestamp = data.get('timestamp').strftime("%Y%m%d")  # timestamp 형식 변경
    
            # Firestore에서 서베이 데이터 가져오기
            survey_ref = db.collection('survey').document(f'survey_{userid}_{timestamp}')
            survey_doc = survey_ref.get()
            if survey_doc.exists:
                survey_data = survey_doc.to_dict()
                username = survey_data.get('username')

            # 상품 추천
            recommended_products = product_recommender(username)

            # Firestore에 추천 결과 저장
            recommend_ref = db.collection('recommend').document(f'survey_{userid}_{timestamp}')
            recommend_ref.set({'recommended_products': recommended_products})

        return 'Recommendation processed', 200
    else:
        return 'Survey data not found', 404

def main():
    # Run monitoring in a separate thread
    monitoring_thread = threading.Thread(target=start_monitoring, args=(output_saved_PATH,))
    monitoring_thread.start()

    # Start Flask server
    app.run(host='0.0.0.0', debug=False, port=5000)
    
if __name__ == '__main__':
    main()
