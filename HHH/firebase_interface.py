import firebase_admin
from firebase_admin import credentials, firestore, storage

import os

PATH = os.getcwd()
input_dir = f'{PATH}/scalp/input/unknown/second_unknown'
# cred = credentials.Certificate(f'{PATH}/database/p4ds-a0e74-firebase-adminsdk-5tp4l-ef9265d951.json')
# firebase_admin.initialize_app(cred, {
#     'storageBucket' : "p4ds-a0e74.appspot.com"
# })
# db = firestore.client()

## uploadEvents 컬렉션에 이벤트 리스너 설정 -> 파일명 일치하는 파일을 스토리지에서 찾아서 VM 서버에 다운로드
def on_snapshot(col_snapshot, changes, read_time):
    for change in changes:
        if change.type.name == 'ADDED':
            # 새로운 이벤트 문서 데이터 가져오기
            doc = change.document.to_dict()
            file_name = doc['fileName']  # 여기서 'fileName'은 문서에서 파일명을 나타내는 필드

            # Storage에서 해당 파일 찾기
            bucket = storage.bucket()
            blob = bucket.blob(f'user1/{file_name}')
            blob.download_to_filename(f'{input_dir}/{file_name}')
            


# data = db.collection('users').document('eAzkQ6yq21k05Bzp7xvU')
# doc = data.get()
# if doc.exists:
#     print("Docs Data:", doc.to_dict())
# else:
#     print("No such docs")