import sys
import os
import torch 
from PIL import Image
import torchvision.transforms as transforms 
from torchvision.utils import save_image

source_file = sys.argv[1]

def crop(im):
    width, height = im.size   # Get dimensions
    new_width, new_height = min(width, height),  min(width, height)

    left = (width - new_width)/2
    top = (height - new_height)/2
    right = (width + new_width)/2
    bottom = (height + new_height)/2

    # Crop the center of the image
    im = im.crop((left, top, right, bottom))
    return im

def resize_source(source_file):
    PATH = os.getcwd()
    source = Image.open(f'{PATH}/hairline/ffhq_image/{source_file}') # 경로 수정 1130 sh10hsw
    source = crop(source)
    target = Image.open(f'{PATH}/hairline/ffhq_image/target.png') # 경로 수정 1130 sh10hsw

    if source.size != target.size:
        source = source.resize((1024, 1024 ))
        #target = target.resize((1024, 1024 ))

    transform = transforms.Compose([ 
        transforms.PILToTensor() 
    ]) 

    source_tensor = transform(source)
    target_tensor = transform(target) 

    if source_tensor.shape != target_tensor.shape or source_tensor.shape[0] > 3:
        # resize to 3d channel
        source_tensor = source_tensor[:3,...]


    # transform to PILImage
    transform = transforms.ToPILImage()
    source_img = transform(source_tensor)

    # save image
    source_img.save(f'{PATH}/hairline/ffhq_image/source.png') # 경로 수정 1130 sh10hsw

    print("...Resize source.png")


