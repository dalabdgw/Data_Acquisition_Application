from flask import Flask, request, jsonify
import pymysql

from setting import DB_NAME, DB_HOST, DB_USER, DB_PASSWORD

app = Flask(__name__)
# MySQL 연결 설정
db = pymysql.connect(
    host=DB_HOST,
    user=DB_USER,
    password=DB_PASSWORD,
    database=DB_NAME
)

# CRUD 연산

# CREATE (데이터 추가)
@app.route('/create', methods=['POST'])
def create():
    cursor = db.cursor()
    data = request.get_json()
    query = "INSERT INTO your_table (column1, column2, ...) VALUES (%s, %s, ...)"
    values = (data['value1'], data['value2'], ...)  # 요청에서 받은 데이터 사용
    cursor.execute(query, values)
    db.commit()
    cursor.close()
    return jsonify({"message": "데이터가 추가되었습니다."})

# READ (데이터 조회)
@app.route('/read/<int:id>', methods=['GET'])
def read(id):
    cursor = db.cursor()
    query = "SELECT * FROM your_table WHERE id = %s"
    cursor.execute(query, (id,))
    result = cursor.fetchone()
    cursor.close()
    if result:
        return jsonify({"data": result})
    else:
        return jsonify({"message": "데이터가 없습니다."})

# UPDATE (데이터 수정)
@app.route('/update/<int:id>', methods=['PUT'])
def update(id):
    cursor = db.cursor()
    data = request.get_json()
    query = "UPDATE your_table SET column1 = %s, column2 = %s, ... WHERE id = %s"
    values = (data['value1'], data['value2'], ..., id)  # 요청에서 받은 데이터 사용
    cursor.execute(query, values)
    db.commit()
    cursor.close()
    return jsonify({"message": "데이터가 수정되었습니다."})

# DELETE (데이터 삭제)
@app.route('/delete/<int:id>', methods=['DELETE'])
def delete(id):
    cursor = db.cursor()
    query = "DELETE FROM your_table WHERE id = %s"
    cursor.execute(query, (id,))
    db.commit()
    cursor.close()
    return jsonify({"message": "데이터가 삭제되었습니다."})

if __name__ == '__main__':
    app.run(debug=True)
