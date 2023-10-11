import database.database_server as db_server


if __name__ == "__main__":

    DB_HOST = input('DB_HOST(IP) 를 입력하세요: ')
    DB_USER = input('사용자 이름을 입력하세요: ')
    DB_PASSWORD = input('사용자 비밀번호를 입력하세요: ')

    # db _Server start
    try:
        db_server.create_app(
            DB_HOST=DB_HOST,
            DB_USER=DB_USER,
            DB_PASSWORD=DB_PASSWORD,
        ).run(host='0.0.0.0', port=50000)
        print('DB SERVER START!')
    except Exception as e:
        print('DB SERVER ERROR')

