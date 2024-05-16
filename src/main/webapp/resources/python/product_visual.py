from matplotlib import pyplot as plt
import numpy as np
import sys
import json
import os

#한글 지정
plt.rcParams['font.family'] ='Malgun Gothic'
plt.rcParams['axes.unicode_minus'] =False

# JSON 형식으로 데이터 읽기
data = sys.stdin.readline()
data_json = json.loads(data)

# 초기화
age_groups = {'10~19': 0, '20~29': 0, '30~39': 0, '40~49': 0, '50~59': 0, '60 이상': 0}

# 데이터 처리
ageList = data_json["ages"]
for age_str in ageList:
    age = int(age_str)
    # 나이에 따라 카운트 증가
    if age > 10 and age < 20:
        age_groups['10~19'] += 1
    elif age < 30:
        age_groups['20~29'] += 1
    elif age < 40:
        age_groups['30~39'] += 1
    elif age < 50:
        age_groups['40~49'] += 1
    elif age < 60:
        age_groups['50~59'] += 1
    else:
        age_groups['60 이상'] += 1

# 그래프 생성
age_ranges = list(age_groups.keys())
age_counts = list(age_groups.values())

index = np.arange(len(age_ranges))

plt.bar(index, age_counts)

# 축 및 제목 설정
plt.xlabel('나이 분포')
plt.ylabel('구입 인원 수')
plt.title('나이에 따른 구매량')
plt.xticks(index, age_ranges)


# 현재 작업 디렉토리 얻기(경로)
current_dir = os.getcwd()

# 이미지 파일명 설정
image_file = "product_visual_image.png"

# 이미지 저장 경로 설정
image_path = os.path.join("C:\\이젠디지탈12\\spring\\shoppingmall-master.zip_expanded\\shoppingmall-master\\src\\main\\webapp\\resources\\python_image", image_file)

# 이미지 파일이 이미 존재하는지 확인하고 있다면 삭제
if os.path.exists(image_path):
    os.remove(image_path)
    
# 그래프를 이미지로 저장
plt.savefig(image_path)
plt.close()
