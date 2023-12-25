import os
import torch
from PIL import Image
import torchvision.transforms as transforms
from torchvision.utils import save_image
import random
import shutil
import argparse
import subprocess

PATH = os.getcwd()

def hairline_pred_run(input_image):
#     # 3. main.py 실행
    subprocess.run([
        'python', 'hairline/main.py',          # 폴더 경로 수정 1130 sh10hsw
        '--input_dir', 'hairline/ffhq_image/', # 폴더 경로 수정 1130 sh10hsw
        '--im_path1', 'source.png', 
        '--im_path2', 'target.png',
        '--output_dir', 'hairline/outputs/',
        '--warp_loss_with_prev_list', 'delta_w', 'style_hair_slic_large',
        '--version', 'final', '--flip_check'
    ], check=True)
    
    #save_all 제거 #1205

