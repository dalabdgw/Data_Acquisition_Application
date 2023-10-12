# Data Annotation Page


## System Architecture

|SYSTEM|
|---|
|![4](https://github.com/dalabdgw/Data_Acquisition_Application/assets/135303032/0d12769c-6940-406a-b208-a74d7e9c31c7)
|

## Database Description
<hr>

- review table

| Field              | Type         | Null | Key         | Extra          | Field Description |
|--------------------|--------------|------|-------------|----------------|-------------------|
| id                 | int          | NO   | Primary key | auto_increment |                   |
| user_id            | varchar(255) | NO   |             |                | 유저 아이디            |
| created_time       | varchar(255) | NO   |             |                | 만들어진 날, 시각        |
| song_id            | int          | NO   |             |                | 노래 테이블 id         |
| part_seq           | int          | NO   |             |                | 몇번 째 파트인지?        |
| music_score        | int          | NO   |             |                | 음악 점수             |
| tech_score         | int          | NO   |             |                | 기술 점수             |
| sound_score        | int          | NO   |             |                | 소리 점수             |
| articulation_score | int          | NO   |             |                | 아티큘레이션 점수         |

- song_part_table
 
| Field    | Type         | Null | Key         | Extra          | Field Description  |
|----------|--------------|------|-------------|----------------|--------------------|
| id       | int          | NO   | PRIMARY KEY | auto_increment |                    |
| song_id  | int          | NO   |             |                | song_table의 id     |
| part_url | varchar(255) | NO   | UNIQUE KEY  |                | S3에 저장되어 있는 파일의 주소 |
| part_seq | int          | NO   |             |                |                    |

- song_table

| Field     | Type         | Null | Key         | Extra          | Field Description |
|-----------|--------------|------|-------------|----------------|-------------------|
| id        | int          | no   | PRIMARY_KEY | auto_increment |                   |
| song_name | varchar(255) | no   | unique_key  |                | 노래 이름 저장          |

<hr>

### ERD  (2023.10.12)
![5](https://github.com/dalabdgw/Data_Acquisition_Application/assets/135303032/33025671-a8d1-4b57-9f15-83d18054849b)

    
<hr>

## USE CASE
![usecase](https://github.com/dalabdgw/Data_Acquisition_Application/assets/135303032/8b0f7fde-f617-465d-979f-3ef06a32fa06)


