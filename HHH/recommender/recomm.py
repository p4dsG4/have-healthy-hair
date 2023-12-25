import pandas as pd
import os
from surprise import Reader, Dataset, KNNBasic
import pickle

PATH = os.getcwd()
# 데이터 로드
data = pd.read_csv('../generator/sample.csv')

# 데이터 준비
reader = Reader(rating_scale=(1, 5))  # 평점의 범위는 1부터 5
data = Dataset.load_from_df(data[['buyer', 'product', 'rating']], reader)
trainset = data.build_full_trainset()

# 아이템 기반 협업 필터링을 위한 설정
sim_options = {
    'name': 'cosine',
    'user_based': False  # 아이템 기반 협업 필터링 활성화
}

# KNN 아이템 기반 협업 필터링 모델
model = KNNBasic(sim_options=sim_options)
model.fit(trainset)

# 모델과 trainset 저장
model_filename = './model/recomm_model.pickle'
trainset_filename = './model/trainset.pickle'

with open(model_filename, 'wb') as f:
    pickle.dump(model, f)

with open(trainset_filename, 'wb') as f:
    pickle.dump(trainset, f)