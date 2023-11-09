import pymysql
import logging
import boto3
from awscli.errorhandler import ClientError
import os



def insertSongTable(song_name, connection):
        # 필요한 변수
        # 1. song_name

        try:
            # MySQL 데이터베이스에 연결

            # 커서 생성
            cursor = connection.cursor()

            # 테이블 생성 쿼리 작성
            insert_query = """
            INSERT INTO song_table(
                song_name
            ) VALUES (
                %s
            );
            """

            data = (
                song_name
            )

            # 테이블 생성 쿼리 실행
            cursor.execute(insert_query, data)
            connection.commit()

            print("테이블 'song_table'에 정상적으로 입력되었습니다.")

            return '200'

        except pymysql.MySQLError as e:
            print("MySQL 에러 발생:", e)
        finally:
            cursor.close()
            connection.close()
    # song_name을 기반으로 song_id값을 추출한다.
    # part_data : 파트 정보 , 튜플 값을 갖기! part_url, part_seq 순으로!
def insertSongPartTable(song_name, part_data, connection):
        # 필요한 변수
        # 1. song_name

        url_list = part_data['video_url_list']
        part_seq_list = part_data['part_seq']

        try:
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

# 생성한 bucket 이름
#bucket = 'testminseobucket'
bucket = input('버킷 이름 입력해주세요.')

location = 'ap-northeast-2'

aws_access_key_id = input('access_key_id : ')
aws_secret_access_key = input('secret_key_id: ')
    # s3 파일 객체 이름
    # aws region
    # 자격 증명

s3_client = boto3.client(
        's3',
        aws_access_key_id=aws_access_key_id,
        aws_secret_access_key= aws_secret_access_key
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
        s3_client.upload_file(file_path, bucket, song_name+'/'+object_name)
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
        'song_name' : song_name,
        'video_url_list' : video_url_list,
        'part_seq' : part_seq
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
def saveToSongPartDb(song_name, data_path, connection):
    insertS3Song(song_name, bucket_name=bucket)
    db_data = upload_file_DirToS3(song_name, data_path)
    try:
        insertSongPartTable(song_name, db_data, connection)
    except Exception as e:
        print(e)
        print('DB 오류 발생! saveToSongPartDb 함수 참조!')



if __name__ == "__main__":
    AWS_RDS_HOST, AWS_RDS_USER, AWS_RDS_PASSWORD = input('스페이스 바로 띄어서 입력하기: ').split(' ')

    connection = pymysql.connect(host=AWS_RDS_HOST, user=AWS_RDS_USER, password=AWS_RDS_PASSWORD, database='annotationDB')

    saveToSongPartDb('Chopinetudedae', './Chopinetudedae/phrase', connection)
    connection = pymysql.connect(host=AWS_RDS_HOST, user=AWS_RDS_USER, password=AWS_RDS_PASSWORD,
                                 database='annotationDB')
    saveToSongPartDb('Chopinetudeop.10no.1', './Chopinetudeop.10no.1/phrase', connection)
    connection = pymysql.connect(host=AWS_RDS_HOST, user=AWS_RDS_USER, password=AWS_RDS_PASSWORD,
                                 database='annotationDB')
    saveToSongPartDb('Chopinetudeop.10no.4', './Chopinetudeop.10no.4/phrase', connection)