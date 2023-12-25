import os
import torch
import torchvision
from torchvision import transforms
from torch.utils.data import DataLoader
import json
import shutil
from PIL import Image
from tqdm import tqdm

def model_2_stat(score_dict):
    priority = {'Type6': 1, 'Type5': 2, 'Type4': 3, 'Type3': 4, 'Type2': 5, 'Type1': 6}
    type_status_dict = {"Type1": "Dry", 
                    "Type2": "Oily", 
                    "Type3": "Sensitive", 
                    "Type4": "Inflammatory", 
                    "Type5": "Dandruff", 
                    "Type6": "Hairloss"}
    if score_dict.get('Type6', 0) == 3:
        return "Hairloss"

    if all(score < 2 for score in score_dict.values()):
        return 'Good'

    highest_score = 2 - 1
    highest_priority = float('inf')
    highest_priority_type = None

    for type, score in score_dict.items():
        if type == 'Type6': continue
        if score > highest_score or (score == highest_score and priority[type] < highest_priority):
            highest_score = score
            highest_priority = priority[type]
            highest_priority_type = type
   
    status = type_status_dict[highest_priority_type] 
    return status


def classify_scalp(temp_dir, model_saved_PATH, prediction_json_dir, user_history_dir, gpu_id):
    png_count = 0
    # png_file_name = '' ## 
    # temp_dir = f"{temp_dir}/true"
    for root, dirs, files in os.walk(temp_dir):
        for file in files:
            if file.endswith(('.png', '.jpg', '.jpeg')): 
                png_count += 1
                png_file_name = os.path.join(root, file)
                # png_file_names.append(png_file_name)
                print(png_file_name)

    # os.makedirs(prediction_json_dir, exist_ok=True)
    # os.makedirs(user_history_dir, exist_ok=True)

    # device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    device = torch.device(gpu_id if torch.cuda.is_available() else "cpu")
    print('device : ', device)

    model_names = ['model1', 'model2', 'model3', 'model4', 'model5', 'model6']
    # for i, file_name in enumerate(png_file_names):
    file_name = png_file_name
    predictions = {}
    for name in tqdm(model_names):
        type_name = 'Type' + name[-1]
        model_to_upload = name
        model_pt = f'{model_saved_PATH}/aram_{model_to_upload}.pt'
        model_weight_pt = f'{model_saved_PATH}/president_aram_{model_to_upload}.pt'

        model = torch.load(model_pt, map_location=device)
        model.load_state_dict(torch.load(model_weight_pt, map_location=device))

        transforms_eval = transforms.Compose([
        transforms.Resize([224, 224], interpolation=4), ###################
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
    ])
        image = Image.open(file_name).convert('RGB')
        image = transforms_eval(image).unsqueeze(0).to(device)  # Add batch dimension and send to device

    # evalset = torchvision.datasets.ImageFolder(temp_dir, transform=transforms_eval)
    # print(evalset.classes)
    # evalloader = DataLoader(evalset, batch_size=4, shuffle=False, num_workers=2)

        model.eval()
        with torch.no_grad():
            output = model(image)
            pred = output.argmax(dim=1, keepdim=True)
            predictions[type_name] = pred.item()
            # print(predictions)   

    stat = model_2_stat(predictions)
    predictions["Condition"] = stat
    # print(stat)
    _filename = file_name.split('/')[-1].split('.')[-2]
    _filename_ = file_name.split('/')[-1]
    with open(f"{prediction_json_dir}/prediction_{_filename}.json", "w") as json_file:
        json.dump(predictions, json_file)

    shutil.move(png_file_name, f'{user_history_dir}{_filename_}')
    # print(f'{png_file_name} has been moved to {user_history_dir}')
    
    return predictions

# define dirs
# PATH = os.getcwd()
# input_data_dir = f'{PATH}/scalp/input/unknown'
# model_saved_PATH = f'{PATH}/scalp/model_pt'
# temp_dir = f'{PATH}/scalp/temp' # 2023-11-29 17:00 추가 - lotus
# prediction_json_dir = f'{PATH}/scalp/user_history/prediction_result/'
# user_history_dir = f'{PATH}/scalp/user_history/images/'

# classify_scalp(temp_dir, model_saved_PATH, prediction_json_dir, user_history_dir)