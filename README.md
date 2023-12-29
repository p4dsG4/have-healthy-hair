# HHH - Have Healthy Hair 
> 2023 Fall - Project for Data Science of GSDS   
> Full-stack development
> Total cost : ₩419,788.38  

![main2](https://github.com/p4dsG4/have-healthy-hair/assets/85481704/9cbf8bb2-7f21-41c1-8675-56de3050dc09)

## Team Member 
Sangwoo Heo(PO, DevOPs), Seungju Lee(ML Expert), Sunyoung Park(UI/UX Designer, Front-end),    
Chaieun Lee(Data engineer, ML Expert), Myungjoo Lee(Data Engineer, ML Expert)

## Process and Stacks 
Process | Tools | Detail
---- | ---- | ----
Compute Engine | <img src="https://img.shields.io/badge/Googlecloud-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white"> | **Stroage** :SCSI, 250GB, x86/64 </br> **GPU** :2 x NVIDIA T4 </br> **VM** :n1-standard-4, Intel Broadwell, x86/64 </br> ₩419,488.38
Networking | <img src="https://img.shields.io/badge/Googlecloud-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white"> | IPv4, Premium </br> ₩3,103
UX Design | <img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white"> | [Design Link](https://www.figma.com/file/6QfBEA8ks5tb51J2z9t3ns/P4DS?type=design&node-id=2-666&mode=design&t=CL3pvZ3CaWQ2zOl5-0)
Modeling | <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=Python&logoColor=white"> | -
Front-end | <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white"> <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white">| personal expenses
Database | <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=Firebase&logoColor=white"> | less than ₩100
Back-end | <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white"> | API 

## Language
<p>
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=Python&logoColor=white">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white">
</p>

## Project Introduction
* **Target** : Who have concerns about hair and scalp.     
* **Function** : It diagnoses the condition of the scalp based on a photo and recommends appropriate products and clinics.       
It records the condition of the scalp seasonally, allowing tracking by period.    
When the records accumulate, it goes further by predicting hair loss in the future.   
* **Demo** : Visit [HERE](https://drive.google.com/file/d/1snh787RhBD-a7VbdnNg9YhhoU_UEtSzK/view?usp=sharing) to see our demo.
* **Test**    
※ The process below is just written as record.    
Whole process cannot be simulated exactly, because this repo is not developed for simulation.   

* clone the repository:
```
git clone https://github.com/p4dsG4/have-healthy-hair.git
```

## Code Structure   
* ```/HHH```
  * ```/functions``` : Back-end.
  * ```/generator``` : Back-end.
  * ```/hairline``` : Hairline prediction generation.
  * ```/recommender``` : Collborative Filtering recommendation.
  * ```/scalp``` : Classifying Scalp or Not & Classifying Scalp condition.

* ```/front``` : Front-end flutter code based on dart. 
* ```/simple-firestore-import``` : Making database.

# Demo
## Front-end
* Mainuplate Flutter in ```/front``` folder
```
cd front
```
Reference from : 
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Back-end
* The ```app.py``` must be running when using the app.
```
cd HHH
python app.py
```

# Step by Step
## 1. Database
* Move to the directory and install dependencies.
```
cd simple-firestore-import
pip install -r requirements.txt
```
* Make json file to upload and run.   
  Format should be ```python {execution}.py {key}.json {upload_file}.json {collection_name} {document_name}```
```
python simple-firestore-import.py {key}.json scalp_ml4.json scalp_ml 20231204
```
Reference from : https://github.com/RobinCheptileh/simple-firestore-import
 
## 2. Models
### 1) EfficientNet
* Move to the folder:
```
cd scalp
```
* Install Dependencies
```
conda create -n {env_name} python=3.7.9
conda activate {env_name}
```
* Run is scalp model to detect if the image is scalp.
```
python is_scalp.py
```
* Run scalp image classification model
```
python scalp.py
```

### 2) GAN
* Move to the folder:
```
cd hairline
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

### 3) Collaborative Filtering
* Move to the folder
```
cd recommender
```

## Reference
https://docs.flutter.dev/get-started/codelab   
https://docs.flutter.dev/cookbook    
https://docs.flutter.dev/    
https://github.com/Taeu/Style-Your-Hair    
https://github.com/RobinCheptileh/simple-firestore-import

