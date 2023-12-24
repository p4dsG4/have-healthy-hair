import pandas as pd
import os
import pickle
from surprise import Reader, Dataset
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

PATH = os.getcwd()

model_path = f'{PATH}/recommender/model/recomm_model.pickle'
trainset_path = f'{PATH}/recommender/model/trainset.pickle'

def product_recommender(buyer_id):
    # 모델 및 trainset 불러오기
    with open(model_path, 'rb') as f:
        model = pickle.load(f)
    with open(trainset_path, 'rb') as f:
        trainset = pickle.load(f)
        
    raw_data = pd.read_csv(f'{PATH}/generator/sample.csv') # Training Data
        
    # 신규 구매 고객인지 확인
    if buyer_id in raw_data['buyer'].unique():
        # 기존 구매 고객: 추천 생성
        buyer_inner_id = trainset.to_inner_uid(buyer_id)
        recommendations = model.get_neighbors(buyer_inner_id, k=2)
        recommended_products = [trainset.to_raw_iid(iid) for iid in recommendations]
    else:
        print("New Customer")
        recommended_products = ["Nothing"]
        # # 신규 구매 고객: 콘텐츠 기반 필터링 수행
        # tfidf = TfidfVectorizer()
        # tfidf_matrix = tfidf.fit_transform(product_descriptions['description'])

        # # 임시 유저 프로필 생성
        # user_profile = tfidf.transform([product_descriptions['description'][0]])
        # cosine_sim = cosine_similarity(user_profile, tfidf_matrix)

        # # 추천 생성
        # sim_scores = list(enumerate(cosine_sim[0]))
        # sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
        # recommended_products = [product_descriptions.iloc[i[0]]['product_id'] for i in sim_scores[:2]]

    return recommended_products



# # 데이터 로드
# data = pd.read_csv(f'{PATH}/generator/sample.csv')

# # 데이터 준비
# reader = Reader(rating_scale=(1, 5))  # 평점의 범위는 1부터 5
# data = Dataset.load_from_df(data[['buyer', 'product', 'rating']], reader)

# # 아이템 기반 협업 필터링을 위한 설정
# sim_options = {
#     'name': 'cosine',
#     'user_based': False  # 아이템 기반 협업 필터링 활성화
# }

# # KNN 아이템 기반 협업 필터링 모델
# model = KNNBasic(sim_options=sim_options)

# # 데이터를 훈련 세트와 테스트 세트로 분할
# trainset, testset = train_test_split(data, test_size=0.25)

# # 모델 훈련
# model.fit(trainset)

# # 테스트 세트에서의 성능 평가
# predictions = model.test(testset)
# accuracy_rmse = accuracy.rmse(predictions)
# accuracy_mae = accuracy.mae(predictions)

# print(f'RMSE: {accuracy_rmse}, MAE: {accuracy_mae}')

# # 특정 사용자에 대한 상품 추천 생성 (예: '이채은')
# buyer_id = '이채은'
# buyer_inner_id = model.trainset.to_inner_uid(buyer_id)

# # 이 사용자에 대한 상품 추천
# recommendations = model.get_neighbors(buyer_inner_id, k=2)

# # 내부 ID를 다시 실제 상품 이름으로 매핑
# recommended_products = [model.trainset.to_raw_iid(iid) for iid in recommendations]

# print(recommended_products)