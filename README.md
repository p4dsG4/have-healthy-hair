# HHH - Have Healthy Hair 
> 2023 Fall - Project for Data Science of GSDS   
> Make application from Front-end to Back-end, including database, modeling   
> Total cost : 48만원

## Team Member 
Sangwoo Heo(PO, DevOPs), Seungju Lee(ML Expert), Sunyoung Park(UI/UX Designer, Front-end),    
Chaieun Lee(Data engineer, ML Expert), Myungjoo Lee(Dev Engineer, ML Expert)

## Process and Stacks 
Process | Tools | Detail
---- | ---- | ----
Storage | <img src="https://img.shields.io/badge/Googlecloud-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white"> | 200GB, x86/64 $153/month, 
GPU | <img src="https://img.shields.io/badge/Googlecloud-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white"> | gpu 2 x NVIDIA T4, 
Networking | <img src="https://img.shields.io/badge/Googlecloud-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white"> | 2,160원 
UX Design | <img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white"> | [Design Link](https://www.figma.com/file/6QfBEA8ks5tb51J2z9t3ns/P4DS?type=design&node-id=2-666&mode=design&t=CL3pvZ3CaWQ2zOl5-0)
Modeling | <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=Python&logoColor=white"> | EfficientNet, GAN 
Front-end | <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white"> <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white">| local, 개인사비
Database | <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=Firebase&logoColor=white"> | $10
Back-end | <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white"> | API 

## Language
<p>
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=Python&logoColor=white">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white">
</p>
<img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white">

## Project Introduction
**Target** : Those who have concerns about hair and scalp.     
**Function** : It diagnoses the condition of the scalp based on a photo and recommends appropriate products and clinics.     
It records the condition of the scalp seasonally, allowing tracking by period.
When the records accumulate, it goes further by predicting hair loss in the future.    
**Test**    
※ The process below is just written as record.    
Whole process cannot be simulated exactly, because this repo is not developed for simulation.   

* clone the repository:
```
git clone https://github.com/p4dsG4/p4ds/hairline.git
cd hairline
```

## Demo
* Run ```app.py```

## Database
### Uploading json file to firestore
* Move to the directory
```
cd simple-firestore-import
```
* Install Dependencies
```
pip install -r requirements.txt
```
* Make json file to upload. 
* Run    
  format is python {execution}.py {key}.json {upload_file}.json {collection_name} {document_name}
```
python simple-firestore-import.py p4ds-a0e74-firebase-adminsdk-5tp4l-ef9265d951.json scalp_ml4.json scalp_ml 20231204
```
Reference from : https://github.com/RobinCheptileh/simple-firestore-import
 
## Modeling
### 2) GAN
* Move to the folder:
```
cd Style-Your-Hair
```
* Install Dependencies
```
conda create -n {env_name} python=3.7.9
conda activate {env_name}
conda install pytorch==1.8.0 torchvision==0.9.0 torchaudio==0.8.0 cudatoolkit=11.1 -c pytorch -c conda-forge
pip install face_alignment face-recognition gdown ipython matplotlib
```
* Put your own image into ```./ffhq_images/``` folder as the name ```input.png```.
 
* Run
You can modify the name ```input.png``` to your image file name.
```
python main.py --input_dir ./ffhq_image/ --im_path1 source.png --im_path2 44894.png \
--output_dir ./outputs/ \
--warp_loss_with_prev_list delta_w style_hair_slic_large \
--save_all --version final --flip_check --resize_source input.png
```
Reference from https://github.com/Taeu/Style-Your-Hair

## Front-end
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Back-end



## Reference
https://github.com/Taeu/Style-Your-Hair
