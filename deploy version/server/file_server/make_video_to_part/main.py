import os
from datetime import datetime


def make_video_to_part(time_data, file_name):
    # input example
    # txt file, mp4 file
    # time_data = "phrase data.txt"
    # file_name = "video.mp4"

    txt_data_path = os.getcwd() + '/datasets/phrase_data/' + time_data
    video_data_path = os.getcwd() + '/datasets/video_data/' + file_name

    print(txt_data_path)
    print(video_data_path)
    try:
        f = open(txt_data_path, 'r')
        line = f.readlines()
        print(line)
    except:
        print('디렉토리 오류')

    save_path = './datasets_part/' + file_name.split('.')[0]
    try:
        os.makedirs(save_path)
    except:
        print('폴더 생성 오류')
    time_list = []
    time_list.append('0:00')

    part_cnt = 0

    for i in range(len(line[0].split(' '))):
        time_list.append(line[0].split(' ')[i])
    try:
        # 파일 경로 문제가 있음
        # !ffmpeg -i {file_name} -ss {start_time} -to {end_time} -c copy output1.mp4
        for i in range(len(time_list) - 1):
            data_name = save_path + "/data" + str(i) + ".mp4"
            start_time = time_list[i]
            end_time = time_list[i + 1]
            print(start_time, end_time)
            os.system(
                'ffmpeg -i ' + './make_video_to_part/video.mp4' + ' -ss ' + start_time + ' -to ' + end_time + ' -c copy ' + data_name)
            part_cnt += 1
    except:
        print('디렉토리 설정 오류')
    return part_cnt
