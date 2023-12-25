from pathlib import Path
from random import choice, choices, randint, random
from datetime import datetime as dt
from datetime import timedelta
import time
import firebase_admin
from firebase_admin import credentials, firestore

# firebase initialize
cred = credentials.Certificate('../functions/p4ds-a0e74-firebase-adminsdk-5tp4l-ef9265d951.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

# Function to upload data to Firestore
def upload_to_firestore(data, collection_name, document_name):
    db.collection(collection_name).document(document_name).set(data, merge=True)

class DataGenerator():
    DATETIME_FMT = '%Y-%m-%dT%H:%M:%S'
    def __init__(self, abnormal_threshold: float=0.99):
        self.names_gender_map = {}
        with Path('names.txt').open('r') as file:
            for line in file:
                name, gender = line.strip().split()
                self.names_gender_map[name] = gender
        self.names = list(self.names_gender_map.keys())
        with Path('products.txt').open('r') as file2:
            self.products = [product.strip() for product in file2.readlines()]
        with Path('status.txt').open('r') as file3:
            self.status = [status.strip() for status in file3.readlines()]
        # build customer information
        self.issued = set()
        self.names_dict = {}
        for n in self.names:
            info = {}
            info['danger'] = (abs(hash(n)) // 1e17) < 8
            n_card = choice([3, 4, 5]) if info['danger'] else choice([1, 2])
            info['cards'] = [self._issue_card_number() for _ in range(n_card)]
            self.names_dict[n] = info
        
        self.abnormal_threshold = abnormal_threshold
        self._reset_normal_cnt()

    def _issue_card_number(self):
        stop_issue = False
        if len(self.issued) >= 273435746624250:
            raise ValueError('Cannot issue a new card')
        while not stop_issue:
            card = '-'.join([str(randint(1000, 9999)) for _ in range(4)])
            if card not in self.issued:
                stop_issue = True
        self.issued.add(card)
        return card

    def _reset_normal_cnt(self):
        self._count = 0
        self._abnormal_count_thres = randint(100, 105)

    def _update_normal_cnt(self):
        self._count += 1
    
    def _check_abnormal_count_thres(self):
        if self._count == self._abnormal_count_thres:
            self._reset_normal_cnt()
            return True
        return False

    def generate_amount(self, name):
        if self.names_dict[name]['danger']:
            abnormal = choices([False, True], weights=[0.6, 0.4])[0]
        else:
            prob = random()
            abnormal = prob >= self.abnormal_threshold

        if self._check_abnormal_count_thres() or abnormal:
            self._reset_normal_cnt()
            return random() * 1e10
        else:
            self._update_normal_cnt()
            amount = random() * choices([1e4, 1e5, 1e6], weights=[0.35, 0.4, 0.1, 0.1, 0.05])[0]
            if amount < 1:
                amount += 1
            return amount

    def generate(self, timestamp: dt):
        name = choice(self.names)
        gender = self.names_gender_map[name]
        product = choice(self.products)
        status = choice(self.status)
        # email_address = name+'@card.com'
        # card_number = choice(self.names_dict[name]['cards'])
        amount = self.generate_amount(name)
        return {
            'ts': timestamp.strftime(self.DATETIME_FMT), 
            'buyer': name,
            'product': product,
            'gender': gender,
            'status': status,
            'amount': amount,
        }

if __name__ == '__main__':
    generator = DataGenerator()
    timestamp = dt.now()
    
    # Generate data
    for i in range(100):  # Example: generate 100 data entries
        # 시간 증가 로직
        random_wait_days = choices([0, 1, 2], weights=[0.80, 0.1, 0.1])[0]
        random_wait_hours = choice([0, 1])
        random_wait_minutes = choice([0, 10, 15, 20, 25])
        random_wait_seconds = choice([0, 1, 3, 5, 10])
        timestamp += timedelta(days=random_wait_days, hours=random_wait_hours, minutes=random_wait_minutes, seconds=random_wait_seconds)
        
        # 데이터 생성
        data = generator.generate(timestamp)

        # Firestore에 데이터 업로드
        document_id = f'purchase_{i}'
        upload_to_firestore(data, 'purchase', document_id)
        
        print('[{0}] Buyer: {1:18} | Product: {2:20} | Gender: {3:3} | Status: {4:15} | Amount: {5:20}'.format(
            data['ts'], data['buyer'], data['product'], data['gender'], data['status'], data['amount']))
        time.sleep(0.5)