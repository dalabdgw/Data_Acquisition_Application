import logging
import boto3
import pymysql
from awscli.errorhandler import ClientError
import os
import requests


def saveToSongPartDb(song_name, data_path):

    location = 'ap-northeast-2'
    s3_client = boto3.client(
        's3',
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
    )

    # S3 파일 업로드 및 url 가져오기
    def upload_file(file_path, file_name, song_name):
        """Upload a file to an S3 bucket

        :param file_name: File to upload
        :param bucket: Bucket to upload to
        :param object_name: S3 object name. If not specified then file_name is used
        :return: True if file was uploaded, else False
        """
        object_name = file_name
        # Upload the file
        try:
            s3_client.upload_file(file_path, bucket, song_name + '/' + object_name)
        except ClientError as e:
            logging.error(e)
            return None
        video_url = f'https://{bucket}.s3.{location}.amazonaws.com/{song_name}/{object_name}'
        return video_url

    # 파일경로 부분 수정 필요, 추가적으로 데이터 이름도 수정 필요
    def upload_file_DirToS3(song_name, data_path):

        video_url_list = []
        part_seq = []
        dir_list = os.listdir(data_path)
        # for part 순서
        for i in range(len(dir_list)):
            part_seq.append(dir_list[i].replace("data", "").split('.')[0])

        for i in range(len(dir_list)):
            path = data_path + '/' + dir_list[i]
            temp_url = upload_file(path, dir_list[i], song_name)
            video_url_list.append(temp_url)
            part_seq.append(i)
        db_data = {
            'song_name': song_name,
            'video_url_list': video_url_list,
            'part_seq': part_seq
        }

        return db_data

    def insertS3Song(song_name, bucket_name):

        folder_name = song_name + '/'
        # 폴더를 생성하기 위한 빈 객체 업로드

        try:
            s3_client.put_object(Bucket=bucket_name, Key=folder_name)
        except:
            print('폴더 생성 오류 발생')

    # 노래 이름 넣으면 해당 노래에 대한 파트 정보를 s3와 데이터베이스에 반영해줌.

    def insertSongPartTable(song_name, part_data):
        # 필요한 변수
        # 1. song_name

        url_list = part_data['video_url_list']
        part_seq_list = part_data['part_seq']

        try:
            # MySQL 데이터베이스에 연결
            connection = pymysql.connect(host='annotationdb.cszainnq3jgr.ap-northeast-2.rds.amazonaws.com', user=db_user, password=db_password, database='annotationDB')
            # 커서 생성
            cursor = connection.cursor()
            insert_q = """
                SELECT id FROM song_table WHERE song_name = %s
            """
            cursor.execute(insert_q, song_name)

            song_id = cursor.fetchone()[0]

            for i in range(len(url_list)):
                # 테이블 생성 쿼리 작성
                insert_query = """
                        INSERT INTO song_part_table(
                            song_id,
                            part_url,
                            part_seq
                        ) VALUES (
                            %s,
                            %s,
                            %s
                        );
                        """
                # 테이블 생성 쿼리 실행
                cursor.execute(insert_query, (song_id, url_list[i], part_seq_list[i]))

            connection.commit()

            print("테이블 'song_part_table'에 정상적으로 입력되었습니다.")

            return '200'

        except pymysql.MySQLError as e:
            print("MySQL 에러 발생:", e)
        finally:
            cursor.close()
            connection.close()

    insertS3Song(song_name, bucket_name=bucket)
    db_data = upload_file_DirToS3(song_name, data_path)
    try:
        json_data = {
            'song_name' : song_name,
            'db_data' : db_data
        }

        insertSongPartTable(song_name, db_data)

    except Exception as e:
        print(e)
        print('DB 오류 발생! saveToSongPartDb 함수 참조!')


# data_path = './phrase'


if __name__ == "__main__":
    # 생성한 bucket 이름
    bucket = 'dataannotationbucket'
    # s3 파일 객체 이름
    # aws region
    location = 'ap-northeast-2'
    # 자격 증명
    s3_client = boto3.client(
        's3',
        aws_access_key_id='?',
        aws_secret_access_key='?'
    )

    # user input!

    db_user = input('db_user? : ')
    db_password = input('db_paasword? : ')
    bucket = input('버킷의 이름을 입력해주세요: ')
    access_key = input('access_key_id를 입력해주세요: ')
    secret_key = input('secret_access_key를 입력해주세요: ')

    while(1):
        print('예시 입력 입니다.')
        print("곡제목: 'Chopinetudedae' 곡 저장 경로: './Chopinetudedae/phrase'")
        print('반드시 곡제목으로 이름이 된 폴더로 지정해야 합니다.')
        print('0 입력 시 데이터 입력 종료.')
        song_name = input('입력 할 곡 제목을 입력 해주세요: ')
        data_path = input('phrase 별로 저장된 폴더 경로를 지정해주세요: ')
        saveToSongPartDb(song_name, data_path)

        if song_name == 0 or data_path == 0:
            break
    #saveToSongPartDb('Chopinetudedae', './Chopinetudedae/phrase')
    #saveToSongPartDb('Chopinetudeop.10no.1', './Chopinetudeop.10no.1/phrase')
    #saveToSongPartDb('Chopinetudeop.10no.4', './Chopinetudeop.10no.4/phrase')
