
'''
1. 파일 다운로드 받기
    - 다운로드 된 파일 경로 알아내기
2. 다운로드 받은 파일 분할해서 파일이름에 해당하는 폴더에 저장하기
    - 분할된 파일 경로 알아내기
3. db에 저장하기

'''
import time
import shutil
from flask import Flask, request, jsonify, send_file
import os
from datetime import datetime
from make_video_to_part import main as m2v

app = Flask(__name__)

# 업로드 파일의 최대 크기 설정 (여기서는 2048MB로 설정)

# 허용된 파일 확장자 설정 (예: 이미지 파일 확장자)
ALLOWED_EXTENSIONS = {'mp4', 'txt'}

def allowed_file(filename):
    # 파일 확장자를 확인하여 허용된 확장자인지 검사
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/upload', methods=['POST'])
def upload_file():

    now = datetime.now()
    current_time = str(now.year) + str(now.month)+str(now.day)+str(now.hour)+str(now.minute)+str(now.second)
    # 업로드된 파일 가져옴.
    uploaded_file = request.files['file']
    uploaded_file_2 = request.files['file2']

    if not uploaded_file:
        return jsonify({'message': '파일을 찾을 수 없습니다.'}), 400

    if not allowed_file(uploaded_file.filename):
        return jsonify({'message': '허용되지 않는 파일 형식입니다.'}), 400

    try:
        os.makedirs('datasets/phrase_data')
        os.makedirs('datasets/video_data')
    except:
        print('폴더 생성되어 있음')

    try:
        # 파일 경로 설정 해주기
        if uploaded_file_2.filename[-3:] == 'txt':
            file_path = 'datasets/phrase_data/phrase_data'+current_time+'.txt'
            uploaded_file_2.save(file_path)
            source = file_path
            destination = r"./make_video_to_part/phrase_data.txt"
            shutil.copyfile(source, destination)
        if uploaded_file.filename[-3:] == 'mp4':
            file_path = 'datasets/video_data/video_data'+current_time+'.mp4'
            uploaded_file.save(file_path)
            source = file_path
            destination = r"./make_video_to_part/video.mp4"
            shutil.copyfile(source, destination)



        time.sleep(5)

        # video to part
        m2v.make_video_to_part('phrase_data'+current_time+'.txt', 'video_data'+current_time+'.mp4')

        # save to database !


        return jsonify({'message': '파일 업로드 성공', 'filename': uploaded_file.filename}), 200
    except Exception as e:
        return jsonify({'message': f'파일 업로드 중 오류 발생: {str(e)}'}), 500


@app.route('/download/<filename>', methods=['GET'])
def download_file(filename):
    try:
        # 다운로드할 파일의 경로를 가져옵니다.
        file_path = os.path.join(os.getcwd(), filename)

        # 파일이 존재하지 않으면 404 오류 반환
        if not os.path.exists(file_path):
            return jsonify({'message': '파일을 찾을 수 없습니다.'}), 404

        # 파일을 클라이언트에게 전송합니다.
        return send_file(file_path, as_attachment=True)
    except Exception as e:
        return jsonify({'message': f'파일 다운로드 중 오류 발생: {str(e)}'}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=50000)
