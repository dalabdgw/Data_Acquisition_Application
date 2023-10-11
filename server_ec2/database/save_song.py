import logging
import boto3
from awscli.errorhandler import ClientError
import os
import requests


def saveToSongPartDb(song_name, data_path):

    bucket = input('버킷의 이름을 입력해주세요: ')
    location = 'ap-northeast-2'
    s3_client = boto3.client(
        's3',
        aws_access_key_id=input('access_key_id를 입력해주세요: '),
        aws_secret_access_key=input('secret_access_key를 입력해주세요: ')
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

    insertS3Song(song_name, bucket_name=bucket)
    db_data = upload_file_DirToS3(song_name, data_path)
    try:
        json_data = {
            'song_name' : song_name,
            'db_data' : db_data
        }
        url = input('저장 할 db의 url을 입력해주세요: ')
        port = input('저장 할 db의 port를 입력해주세요: ')
        response = requests.post('http://'+url+':'+port+'/input_song_part_data', json=json_data)
        #insertSongPartTable(song_name, db_data)
        print(response)
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
        aws_access_key_id='AKIA3JFVCDNBC7UAPV7B',
        aws_secret_access_key='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'
    )

    saveToSongPartDb('Chopinetudedae', './Chopinetudedae/phrase')
    saveToSongPartDb('Chopinetudeop.10no.1', './Chopinetudeop.10no.1/phrase')
    saveToSongPartDb('Chopinetudeop.10no.4', './Chopinetudeop.10no.4/phrase')