import os
import torch
from torchvision import transforms
import torch.nn as nn
from torch.utils.data import DataLoader
from PIL import Image
import shutil
# Anomaly Detection model with AutoEncoder 로 전면 수정 20231204 lotus

class Autoencoder(nn.Module):
    def __init__(self):
        super(Autoencoder, self).__init__()
        # Encoder
        self.encoder = nn.Sequential(
            nn.Conv2d(3, 32, 4, stride=1, padding=1),  # [batch, 32, 112, 112]
            nn.BatchNorm2d(32),
            nn.ReLU(),
            nn.Conv2d(32, 64, 4, stride=1, padding=1), # [batch, 64, 56, 56]
            nn.BatchNorm2d(64),
            nn.ReLU(),
            nn.Conv2d(64, 128, 4, stride=1, padding=1), # [batch, 128, 28, 28]
            nn.BatchNorm2d(128),
            nn.ReLU(),
            nn.Conv2d(128, 256, 4, stride=1, padding=1), # [batch, 256, 14, 14]
            nn.BatchNorm2d(256),
            nn.ReLU(),
            nn.Conv2d(256, 512, 4, stride=1, padding=1), # [batch, 512, 7, 7]
            nn.BatchNorm2d(512),
            nn.ReLU()
        )
        # Decoder
        self.decoder = nn.Sequential(
            nn.ConvTranspose2d(512, 256, 4, stride=1, padding=1),
            nn.BatchNorm2d(256),
            nn.ReLU(),
            nn.ConvTranspose2d(256, 128, 4, stride=1, padding=1),
            nn.BatchNorm2d(128),
            nn.ReLU(),
            nn.ConvTranspose2d(128, 64, 4, stride=1, padding=1),
            nn.BatchNorm2d(64),
            nn.ReLU(),
            nn.ConvTranspose2d(64, 32, 4, stride=1, padding=1),
            nn.BatchNorm2d(32),
            nn.ReLU(),
            nn.ConvTranspose2d(32, 3, 4, stride=1, padding=1),
            nn.Sigmoid()  # Output should be in the range [0, 1]
        )

    def forward(self, x):
        x = self.encoder(x)
        x = self.decoder(x)
        return x

def preprocess_image(image_path):
    transform = transforms.Compose([
            transforms.Resize(256),
            transforms.CenterCrop(224),
            transforms.ToTensor(),
            transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])])
    image = Image.open(image_path).convert('RGB')  # Convert image to RGB
    image = transform(image).unsqueeze(0)  # Add batch dimension
    return image

def is_scalp_image(input_data_dir, model_saved_PATH, temp_dir):
    # 이미지가 두피 이미지인지 확인하는 로직
    # firebase로 들어온 이미지가 'input_data_dir = /data/HHH/scalp/input/unknown' 로 다운로드됨을 가정 
    # 모델은 'model_saved_PATH = /data/HHH/scalp/model_pt'에 있고,
    # 이미지 두피 여부 true false 담는 map은 이 함수에서 리턴하여 변수로 저장
    # 이미지 두피 여부 true false에 따라, input_data_dir+'/'+'true' 에 이미지가 이동됨
    # 나중에 app.py에서, input_data_dir+'/'+'true'에 있는 이미지만 classify_scalp 함수에 먹여져 두피상태 분류됨


    # Load the model
    model = Autoencoder()
    model_pt = f'{model_saved_PATH}/aram_model0.pth'
    model.load_state_dict(torch.load(model_pt))
    # print("model loaded!")
    model.eval()  # set the model to evaluation mode

    # mkdir for success is True / False 
    # os.makedirs(temp_dir+'/'+'true', exist_ok=True) ## /data/HHH//scalp/temp/true
    # os.makedirs(temp_dir+'/'+'false', exist_ok=True) ## /data/HHH//scalp/temp/false

    image_path = ''
    for image_ in os.listdir(input_data_dir):
        # print(image_)
        image_path += f'{input_data_dir}/{image_}'

    image = preprocess_image(image_path)
    # print("image preprocessed!")
            # Predict and calculate reconstruction error
    with torch.no_grad():  # No need to track gradients during prediction
        reconstructed_image = model(image)
        loss = nn.MSELoss()
        reconstruction_error = loss(reconstructed_image, image)
        # print(f' The {image_path} Reconstruction Error: {reconstruction_error.item()}')
        is_scalp_output = {}
        threshold = 0.32
        is_scalp = reconstruction_error.item() < threshold # True if the error is less than threshold.
        is_scalp_output['success'] = is_scalp
    
        # 두피 이미지로 확인되면, 
        # 해당 이미지를 temp_dir 이하 true/unknown로 옮김
        _filename = image_path.split('/')[-1]
        if is_scalp_output['success']:
            shutil.move(image_path, f"{temp_dir}/true/unknown/{_filename}")
        else:
            shutil.move(image_path, f"{temp_dir}/false/{_filename}")

    return is_scalp_output

    
# PATH = os.getcwd()
# input_data_dir = f'{PATH}/scalp/input/unknown'
# model_saved_PATH = f'{PATH}/scalp/model_pt'
# temp_dir = f'{PATH}/scalp/temp' # 2023-11-29 17:00 추가 - lotus
# user_history_dir = f'{PATH}/scalp/user_history/images/'
# # main
# print(is_scalp_image(input_data_dir, model_saved_PATH, temp_dir))