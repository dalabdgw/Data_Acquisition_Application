# DATA ANNOTATION PAGE

# How to Use?

|                                                                                                         |||    
|---------------------------------------------------------------------------------------------------------|----|----|
| ![1](https://github.com/dalabdgw/Data_Acquisition_Application/assets/135303032/e00a8c2b-5737-4b34-a5a1-73e5dabd0342) |![2](https://github.com/dalabdgw/Data_Acquisition_Application/assets/135303032/b74f0249-ba83-49e6-b2ed-b450934cc00d)|![3](https://github.com/dalabdgw/Data_Acquisition_Application/assets/135303032/53e0bb5d-ac27-4062-9a18-740ca341060a)


## Database Description, System Architecture

-> URL : https://github.com/dalabdgw/Data_Acquisition_Application/tree/master/server

## Server Routing Info

-> URL : https://github.com/dalabdgw/Data_Acquisition_Application/tree/master/server/database


# How to Input Song?

1. Go Dir to "/server/database/"
2. You can find "save_song.py"
3. Use "saveToSongPartDb" Method <br>

Example 
```commandline
connection = pymysql.connect(host=AWS_RDS_HOST, user=AWS_RDS_USER, password=AWS_RDS_PASSWORD,
                                 database='annotationDB')
saveToSongPartDb('Chopinetudeop.10no.4', './Chopinetudeop.10no.4/phrase', connection)
```

## Working Contents.

| Date          | Contents                                          | Link |    
|---------------|---------------------------------------------------|------|
| 2023.10.16(월) | 1. 평가 데이터 저장 기능 (수정)<br/> 2. 새로운 데이터 DB에 반영 코드 작성 |      |
| 2023.10.19(수) | 1. 사용자 구분을 위해 접속 시 사용자 명 입력 받기<br/>2. code 정리     ||









