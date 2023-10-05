from flask import Flask, jsonify, request
import pymysql
from datetime import datetime


DB_HOST = ''
DB_PORT = ''
DB_USER = ''
DB_PASSWORD = ''
DATABASE = 'annotationDB'

def create_app():
    app = Flask(__name__)

    DB_HOST = input('데이터베이스 ip 입력 해주세요: ')
    DB_USER = input('user 입력 해주세요: ')
    DB_PASSWORD = input('password ip 입력 해주세요: ')


    # db 연결
    makeAnnotationDatabase()
    makeSongListTable()
    makeSongPartListTable()
    makeReviewTable()

    insertSongTable('Chopinetudedae')
    insertSongTable('Chopinetudeop.10no.1')
    insertSongTable('Chopinetudeop.10no.4')

    # 음악 파트 리스트를 노래이름을 기반으로 불러온다.
    @app.route('/load_song_part_list', methods=['GET'])
    def load_song_part_list():
        song_name = request.args.get('song_name')
        data = loadSongPartTable(song_name)
        return jsonify(data)

    @app.route('/save_review_data', methods=['POST'])
    def save_review_data():

        review_data = request.json

        try:
            insertReviewTable(
                song_name=review_data['song_name'],
                part_num=review_data['part_num'],
                user_id=review_data['user_id'],
                music_score=review_data['music_score'],
                tech_score=review_data['tech_score'],
                sound_score=review_data['sound_score'],
                articulation_score=review_data['articulation_score']
            )
        except Exception as e:
            print(e)

        return '200'

    @app.route('/load_song_list', methods=['GET'])
    def load_song():
        data = []
        list = loadSongName()
        for i in list:
            data.append(i[0])
        return jsonify(data)

    @app.route('/load_user_review')
    def load_user_review():
        user_id = request.args.get('user_id')

        song_name_list = loadReviewSong(user_id)

        return jsonify(song_name_list)

    @app.route('/load_part_review')
    def load_part_review():
        user_id = request.args.get('user_id')
        song_name = request.args.get('song_name')

        part_review_list = loadReviewPart(user_id, song_name)

        return jsonify(part_review_list)

    return app


# db connector
def connect_to_db():
    # 데이터베이스 연결 설정
    db_host = DB_HOST
    db_user = DB_USER
    db_password = DB_PASSWORD
    database = DATABASE
    # 데이터베이스 연결
    connection = pymysql.connect(host=db_host, user=db_user, password=db_password, database=database)

    return connection


# annotation DB 만들기
def makeAnnotationDatabase():
    try:
        # 데이터베이스 연결 설정
        db_host = DB_HOST
        db_user = DB_USER
        db_password = DB_PASSWORD

        # 데이터베이스 연결
        connection = pymysql.connect(host=db_host, user=db_user, password=db_password)

        # 커서 생성
        cursor = connection.cursor()

        # 새 데이터베이스 생성 (이미 존재하는 경우 무시)
        db_name = 'annotationDB'
        create_db_query = f"CREATE DATABASE IF NOT EXISTS {db_name};"
        cursor.execute(create_db_query)

        if cursor.rowcount == -1:
            print(f"데이터베이스 '{db_name}'가 이미 존재합니다.")
        else:
            print(f"데이터베이스 '{db_name}'가 성공적으로 생성되었습니다.")


    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


# table 만들기
def makeSongListTable():
    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        # 테이블 생성 쿼리 작성
        create_table_query = """
        CREATE TABLE IF NOT EXISTS song_table (
            id INT AUTO_INCREMENT PRIMARY KEY,
            song_name VARCHAR(255) NOT NULL unique key
        );
        """

        # 테이블 생성 쿼리 실행
        cursor.execute(create_table_query)

        print("테이블 'song_table'가 성공적으로 생성되었습니다.")

        return '200'
    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


def makeSongPartListTable():
    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        # 테이블 생성 쿼리 작성
        create_table_query = """
        CREATE TABLE IF NOT EXISTS song_part_table (
            id INT AUTO_INCREMENT PRIMARY KEY,
            song_id INT NOT NULL,
            part_url VARCHAR(255) NOT NULL unique key,
            part_seq INT NOT NULL,
            foreign key (song_id) references song_table(id)
        );
        """

        # 테이블 생성 쿼리 실행
        cursor.execute(create_table_query)

        print("테이블 'song_part_table'가 성공적으로 생성되었습니다.")

        return '200'

    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


def makeReviewTable():
    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        # 테이블 생성 쿼리 작성
        create_table_query = """
        CREATE TABLE IF NOT EXISTS review_table(
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id VARCHAR(255) NOT NULL,
            created_time VARCHAR(255) NOT NULL unique key,
            song_id INT NOT NULL,
            part_seq INT NOT NULL,
            foreign key (song_id) references song_table(id),
            music_score INT NOT NULL,
            tech_score INT NOT NULL,
            sound_score INT NOT NULL,
            articulation_score INT NOT NULL 
        );
        """

        # 테이블 생성 쿼리 실행
        cursor.execute(create_table_query)

        print("테이블 'review_table'가 성공적으로 생성되었습니다.")

        return '200'

    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


# insert func
# song_name 해당하는  song_name을 입력!
def insertSongTable(song_name):
    # 필요한 변수
    # 1. song_name

    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

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
def insertSongPartTable(song_name, part_data):
    # 필요한 변수
    # 1. song_name

    url_list = part_data['video_url_list']
    part_seq_list = part_data['part_seq']

    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()
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


'''
song_name : song_name을 기반으로 song_id 값 추출
part_num : 몇번 째 파트 인지 기록하기위해
user_id : 어떤 유저가 데이터를 저장하는지에 대해
그외 나머지 점수.
'''


def insertReviewTable(song_name, part_num, user_id, music_score, tech_score, sound_score, articulation_score):
    # 필요한 변수
    # 1. song_name
    # 2. part_num
    # 3. user_id

    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        insert_q = """
                    SELECT id FROM song_table WHERE song_name = %s
                """
        cursor.execute(insert_q, song_name)

        song_id = cursor.fetchone()[0]

        now = datetime.now()
        date_str = '' + str(now.year) + ' ' + str(now.month) + ' ' + str(now.day) + ' ' + str(now.hour) + ' ' + str(
            now.minute) + ' ' + str(now.second)

        # 테이블 생성 쿼리 작성
        insert_query = """
        INSERT INTO review_table(
            user_id,
            song_id,
            part_seq,
            music_score,
            tech_score,
            sound_score,
            articulation_score,
            created_time
        ) VALUES (
            %s,
            %s,
            %s,
            %s,
            %s,
            %s,
            %s,
            %s
        );
        """

        data = (
            user_id,
            song_id,
            part_num,
            music_score,
            tech_score,
            sound_score,
            articulation_score,
            date_str
        )

        # 테이블 생성 쿼리 실행
        cursor.execute(insert_query, data)
        connection.commit()

        print("테이블 'review_table'에 성공적으로 입력되었습니다.")

        return '200'

    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


# 데이터 조회 함수
# song_name : 곡 이름에 해당하는 파트 별 동영상 추출!
def loadSongPartTable(song_name):
    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        insert_q = """
            SELECT id FROM song_table WHERE song_name = %s
        """
        cursor.execute(insert_q, song_name)

        song_id = cursor.fetchone()[0]

        # 테이블 생성 쿼리 작성
        insert_query = """
            SELECT part_url, part_seq FROM song_part_table WHERE song_id = %s
        """

        # 테이블 생성 쿼리 실행
        list_song_dict = []
        song_dict = {}
        cursor.execute(insert_query, song_id)
        part_list = cursor.fetchall()

        for i in part_list:
            song_dict = {}
            song_dict['part_url'] = i[0]
            song_dict['part_seq'] = i[1]
            list_song_dict.append(song_dict)

        for i in range(len(list_song_dict)):
            for j in range(len(list_song_dict) - i - 1):
                if list_song_dict[j]['part_seq'] > list_song_dict[j + 1]['part_seq']:
                    temp = list_song_dict[j]
                    list_song_dict[j] = list_song_dict[j + 1]
                    list_song_dict[j + 1] = temp

        print("테이블 'song_part_table'에서 데이터 조회 완료.")

        return list_song_dict

    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


# user_id : 유저 id를 기반으로 리뷰 데이터 수집!
def loadReviewDataTable(user_id):
    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        insert_q = """
            SELECT * FROM review_table WHERE user_id = %s
        """
        cursor.execute(insert_q, user_id)
        review_list = cursor.fetchall()
        print("테이블 'review_table'에서 데이터 조회 완료.")

        list_dict_review = []
        dict_review = {}
        for i in review_list:
            dict_review['song_id'] = i[2]
            dict_review['part_seq'] = i[3]
            dict_review['music_score'] = i[4]
            dict_review['tech_score'] = i[5]
            dict_review['sound_score'] = i[6]
            dict_review['articulation_score'] = i[7]
            list_dict_review.append(dict_review)

        return list_dict_review

    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


# user_id : 유저 id를 기반으로 곡 정보 출력
def loadReviewSong(user_id):
    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        insert_q = """
            SELECT DISTINCT song_id FROM review_table WHERE user_id = %s
        """
        cursor.execute(insert_q, user_id)
        song_id_list = cursor.fetchall()
        print("테이블 'review_table'에서 데이터 song_id 조회 완료.")

        song_name_list = []

        for i in song_id_list:
            insert_q = """
                                SELECT song_name FROM song_table WHERE id = %s
                            """
            cursor.execute(insert_q, i[0])
            song_name = cursor.fetchall()[0][0]
            song_name_list.append(song_name)
        return song_name_list

    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


def loadReviewPart(user_id, song_name):
    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        insert_q = """
                    SELECT id FROM song_table WHERE song_name = %s
                """
        cursor.execute(insert_q, song_name)
        song_id = cursor.fetchall()[0]
        insert_q = """
            SELECT * FROM review_table WHERE user_id = %s and song_id = %s
        """
        cursor.execute(insert_q, (user_id, song_id[0]))
        review_list = cursor.fetchall()


        part_list = []
        music_score_list = []
        tech_score_list = []
        sound_score_list = []
        articulation_score_list = []
        created_date_list = []

        print(review_list)
        for i in review_list:
            created_date_list.append(i[2])
            part_list.append(i[4])
            music_score_list.append(i[5])
            tech_score_list.append(i[6])
            sound_score_list.append(i[7])
            articulation_score_list.append(i[8])

        json_data = {
            'part_list': part_list,
            'music_score_list': music_score_list,
            'tech_score_list': tech_score_list,
            'sound_score_list': sound_score_list,
            'articulation_score_list': articulation_score_list,
            'created_date_list': created_date_list
        }
        print(json_data)
        print("테이블 'review_table'에서 데이터 조회 완료.")

        return json_data

    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


def loadSongName():
    try:
        # MySQL 데이터베이스에 연결
        connection = connect_to_db()

        # 커서 생성
        cursor = connection.cursor()

        insert_q = """
            SELECT song_name FROM song_table
        """
        cursor.execute(insert_q)
        song_list = cursor.fetchall()

        print("테이블 'song_table'에서 데이터 조회 완료.")

        return song_list

    except pymysql.MySQLError as e:
        print("MySQL 에러 발생:", e)
    finally:
        cursor.close()
        connection.close()


if __name__ == "__main__":
    create_app().run(host='0.0.0.0', port=50000, debug=True)
