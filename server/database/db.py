import sqlite3
import make_video_to_part.main as v2p

def makeDB():
    # create database and make table
    conn = sqlite3.connect('piano.db')
    # cursor

    cur = conn.cursor()

    sql = '''
        CREATE TABLE IF NOT EXISTS piano_data(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT NOT NULL, 
            song_name TEXT NOT NULL,
            song_part_name TEXT NOT NULL,
            music_score INTEGER NOT NULL,
            tech_score INTEGER NOT NULL,
            sound_score INTEGER NOT NULL,
            articulation INTEGER NOT NULL
            )
    '''
    cur.execute(sql)
    conn.commit()

    sql2 = '''
        CREATE TABLE IF NOT EXISTS song_data(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT NOT NULL,
            url  Char(255) NOT NULL 
            )
    '''

    cur.execute(sql2)
    conn.commit()

    sql3 = '''
        CREATE TABLE IF NOT EXISTS song_part_data(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            part INTEGER NOT NULL, 
            song_name_id INTEGER NOT NULL,
            url Char(255) NOT NULL,
            FOREIGN KEY("song_name_id") REFERENCES song_data(id)
            )
    '''
    cur.execute(sql3)
    conn.commit()
    cur.close()
    conn.close()

def insert_song(name, origin_url, part_cnt, part_url):
    # name : 음악 이름
    # origin_url : 음악 저장 경로
    # part의 개수 : 총 몇개인지?
    # part의 url : 리스트의 형태로 모든 파트의 주소값이 들어가 있어야함.
    song_data_list = [name, origin_url]



    # 음악 db에 저장 , 음악 이름과, 파일 위치 url
    conn = sqlite3.connect('piano.db')
    cur = conn.cursor()
    sql = '''
        INSERT INTO song_data(name, url) VALUES(?, ?)
    '''
    cur.execute(sql, song_data_list)
    conn.commit()

    # 저장된 음악의 id값 조회
    sql = '''
        SELECT id from song_data WHERE name=?
    '''
    cur.execute(sql, name)
    id = cur.fetchone()

    # 음악 part db에 저장
    sql = '''
        INSERT INTO song_part_data(part, url, song_name_id) VALUES(?, ?, ?)
    '''
    data = []
    for i in range(len(part_cnt)):
        data.append([i, id, part_url[i]])

    cur.executemany(sql, data)
    conn.commit()

    cur.close()
    conn.close()

def insert_piano_data(name, song_name, song_part_name, music_score, tech_score, sound_score, articulation):
    #piano_data_list = ['박민서', '녹턴', 'part0', 1, 1, 1, 1]
    piano_data_list = [name, song_name, song_part_name, music_score, tech_score, sound_score, articulation]

    conn = sqlite3.connect('piano.db')
    cur = conn.cursor()

    sql = '''
        INSERT INTO piano_data(name, song_name,song_part_name, music_score, tech_score, sound_score, articulation) VALUES(?, ?,?, ?, ?, ?, ?) 
    '''
    cur.execute(sql, piano_data_list)
    conn.commit()
    cur.close()
    conn.close()

def get_piano_data(name):
    try:
        varList = [name]

        conn = sqlite3.connect('piano.db')
        cur = conn.cursor()

        sql = '''
            SELECT * from piano_data WHERE name == ?
        '''

        cur.execute(sql, varList)

        result= []
        for i in cur.fetchall():
            result.append(i)
        cur.close()
        conn.close()
        return result
    except:
        print('해당 이름은 없습니다')

def delete_piano_data(name):
    try:
        varList = [name]
        conn = sqlite3.connect('piano.db')
        cur = conn.cursor()
        sql = '''
            DELETE FROM piano_data WHERE name == ?
        '''
        cur.execute(sql, varList)
        conn.commit()
        cur.close()
        conn.close()
    except:
        print('삭제하는 도중 오류 발생!')
