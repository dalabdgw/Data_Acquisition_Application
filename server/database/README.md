# DATABASE ERD

| TABLE      ||
|------------|----|
| SONG_TABLE ||

# save_song.py 
<hr>

"save_song.py" file is for saving song to aws s3 file server.

## function Description


| name             | input parameters                  | output parameters |
|------------------|-----------------------------------|-------------------|
| saveToSongPartDb | Str: song_name<br/>Str: data_path | None              |

<hr>

# Setting.py 
<hr>
"Setting.py" : define Constant. <br>
.env 파일에 데이터베이스 내용 추가.

<hr>

# Data_loder.py 
<hr>

## function Description



## Description API


### Router List
- GET
- POST
- PUT
- DELETE





<hr>

# DB.py ###############################
<hr>

## Description API

### Router List 요약
- GET
 
| Name                | Description                  |
|---------------------|------------------------------|
| ping                | 서버 작동 여부를 판단하기 위한 라우터        |
| load_song_list      | 저장되어 있는 노래의 목록을 반환한다.        |
| load_song_part_list | 저장되어 있는 노래의 Phrase 목록을 반환한다. |
|load_user_review| 유저의 리뷰 데이터 목록을 반환한다.         |
|load_part_review|유저의 phrase 별 평가 목록을 반환한다.|


- POST

| Name                | Description                  |
|---------------------|------------------------------|
|save_review_data|새로운 리뷰 데이터를 저장한다.|

- PUT
- DELETE


### Router List 자세한 사항
| Name                | HTTP Method | Query Parameters                | Return Value                    |
|---------------------|-------------|---------------------------------|---------------------------------|
| Ping                | GET         | None                            | Str: 'server Working'           |
| load_song_part_list | GET         | str: song_name                  | Str: part_url<br/>Str: part_seq |
| save_review_data    | POST        | json_data<br/>review_data       | None                            |
| load_song_list      | GET         | None                            | Str: song_list                  |
| load_user_review    | GET         | Str: user_id                    | Str: review_data                |
| load_part_review    | GET         | Str: user_id<br/>Str: song_name | Str: review_Data                |

