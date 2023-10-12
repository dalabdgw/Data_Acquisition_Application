import 'dart:convert';

import 'package:data_annotation_page/server_info.dart';
import 'package:dio/dio.dart';
/*
1. songList 불러오기
  (곡 리스트 불러오기)
2. part 동영상 불러오기
  -> 현재 선택된 곡을 기반으로 part 데이터를 불러온다.
  (곡명, 파트 동영상 명)
3. 평가 데이터 저장하기

4. 평가 데이터 확인하기
 */


// 서버 곡 리스트를 불러온다.
Future<List> loadSongList() async {

  print('호출');
  Dio dio = Dio();

  Response response = await dio.get(AWSRDSIP+'/load_song_list');

  List<dynamic> responseBody = response.data;
  return responseBody;
 }
// 곡에 대한 part 동영상을 불러온다.
Future<List> loadPartVideoList(song_name) async {
  print('호출');
  Dio dio = Dio();

  Response response = await dio.get(AWSRDSIP+'/load_song_part_list',queryParameters: {'song_name' : song_name});
  List<dynamic> responseBody = response.data;
  return responseBody;
}

// 평가 데이터를 저장하기
Future<int?> saveReviewData(song_name, part_num, user_id, music_score, tech_score, sound_score, articulation_score) async {

  Dio dio = Dio();

  Map<String, String> json_data = {
    'song_name' : song_name,
    'part_num' : part_num,
    'user_id' : user_id,
    'music_score' : music_score,
    'tech_score' : tech_score,
    'sound_score' : sound_score,
    'articulation_score' : articulation_score
  };

  Response response = await dio.post(AWSRDSIP+'/save_review_data', data: json_data);


  return response.statusCode;
}

// 평가 데이터를 조회하기
Future<List> loadReviewData(user_id) async {

  Dio dio = Dio();

  Response response = await dio.get(AWSRDSIP+'/load_user_review', queryParameters: {'user_id' : user_id});
  List<dynamic> responseBody = response.data;
  return responseBody;
}
//평가 데이터 자세히 조회하기
Future<Map<dynamic, List>> loadReviewPartData(user_id, song_name) async {

  Dio dio = Dio();

  Response response = await dio.get(AWSRDSIP+'/load_part_review', queryParameters: {'user_id' : user_id, 'song_name' : song_name});

  Map<dynamic, List<dynamic>> map = Map.from(response.data);

  return map;
}

// 평가 데이터 수정하기
Future<int?> modifyReviewData() async {

  Dio dio = Dio();

  Response response = await dio.post(AWSRDSIP);


  if(response.statusCode == 200){
    /*
    return data 형식
     {
      "name" : "박민서",
      "song_name" : "곡명",
      "part_num" : "1번째 파트",
      "music_score" : "음악점수",
      "tech_score" : "기술점수",
      "sound_score" : "소리점수",
      "articulation_score" : "아티큘레이션 점수"
     }
     */
    return 200;
  }else{
    return response.statusCode;
  }
}