import 'dart:convert';
import 'dart:typed_data';

import 'package:data_annotation_page/main_function/data_check_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';

import '../server_info.dart';

class MainFunctionScreen extends StatefulWidget {
  const MainFunctionScreen({super.key});

  @override
  State<MainFunctionScreen> createState() => _MainFunctionScreenState();
}

class _MainFunctionScreenState extends State<MainFunctionScreen> {

  // 데이터 베이스에 저장할 내용 입력하기
  String current_user_name = '박민서'; // 이름
  String current_song_name = '녹턴'; // 현재 곡 이름
  String current_song_data_name = 'part0'; // 현재 곡의 몇번 째 부분인지?
  String musicScore = '';
  String techScore = '';
  String soundScore = '';
  String articulation = '';


  //데이터 베이스에서 불러올 내용 입력하기
  // 곡 리스트 이름
  List<String> songList = ['곡1'];
  List<String> videoList = [
    'asset/video/Chopinetudeop.10no.1/phrase/data0.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data1.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data2.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data3.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data4.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data5.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data6.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data7.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data8.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data9.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data10.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data11.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data12.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data13.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data14.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data15.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data16.mp4',
    'asset/video/Chopinetudeop.10no.1/phrase/data17.mp4',

  ];




  // 곡 리스트 위젯
  List<Widget> songListWidget = [];
  int videoCursor = 0;

  late VideoPlayerController _controller;
  final formKey = GlobalKey<FormState>();

  // 곡 업로드 시 필요한 위젯 변수 값
  bool isSendSong = false;
  bool isSendTXT = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    super.initState();
    /* for network
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    */
    // 'asset/video/Chopinetudedae/phrase/data0.mp4'
    _controller = VideoPlayerController.asset(videoList[0])
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${current_user_name}님'),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> DataCheckPage()));
          }, child: Text('check data'))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // 동영상
              Container(
                width: MediaQuery.of(context).size.width,
                height: 500.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text('곡 리스트'),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ElevatedButton(onPressed: (){
                                          showDialog(context: context, builder: (BuildContext context){
                                            return AlertDialog(
                                              title: Text('곡 등록하기'),
                                              content: Column(
                                                children: [
                                                  Text('원하시는 곡과 다음 형태의 phrase data 파일을 등록해주세요'),
                                                  ElevatedButton(
                                                      onPressed: () async {

                                                        Dio dio = Dio();
                                                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                          type: FileType.custom,
                                                          allowedExtensions: ['mp4'],
                                                        );
                                                        FilePickerResult? result2 = await FilePicker.platform.pickFiles(
                                                          type: FileType.custom,
                                                          allowedExtensions: ['txt'],
                                                        );
                                                        if (result != null) {
                                                          FormData formData = FormData.fromMap(

                                                              {
                                                              'file': MultipartFile.fromBytes(
                                                              result.files.single.bytes!,
                                                              filename: result.files.single.name,
                                                            ),
                                                            'file2' : MultipartFile.fromBytes(
                                                              result2!.files.single.bytes!,
                                                              filename: result2.files.single.name,
                                                            ),
                                                          }
                                                          );


                                                          showDialog(context: context, builder: (BuildContext context){
                                                            return AlertDialog(
                                                              title: Text('전송 중'),
                                                              content: Container(
                                                                child: CircularProgressIndicator(),
                                                              ),
                                                            );
                                                          });

                                                          // Flask API 엔드포인트에 파일을 업로드합니다.
                                                          Response response = await dio.post(
                                                            MYSERVERIP+MYFILESERVERPORT+'/upload',
                                                            data: formData,
                                                          );
                                                          if (response.statusCode == 200){
                                                            Navigator.pop(context);
                                                          }
                                                          showDialog(context: context, builder: (BuildContext context){
                                                            return AlertDialog(
                                                                title: Text('전송완료'),
                                                                content: ElevatedButton(
                                                                  onPressed: (){
                                                                    isSendSong = true;
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Text('확인'),
                                                                )
                                                            );
                                                          });
                                                        }


                                                      }, child: Text('동영상과 phrase 파일을 업로드 해주세요.')),

                                                  ElevatedButton(onPressed: () async {

                                                      if(isSendSong && isSendTXT){
                                                          isSendSong = false;
                                                          isSendTXT = false;
                                                      }else{
                                                        showDialog(context: context, builder: (BuildContext contest){
                                                          return AlertDialog(
                                                            title: Text('업로드를 안했습니다'),

                                                          );
                                                        });
                                                      }


                                                    }
                                                  , child: Text('변환하기')),
                                                ],
                                              ),
                                            );
                                          });
                                        }, child: Text('곡 등록하기')),
                                      )

                                    ]
                                  )
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: FutureBuilder(
                                      future: renderSongListWidget(),
                                      builder: (BuildContext context, AsyncSnapshot snapshot){
                                        return Column(
                                          children: songListWidget,
                                        );
                                      },
                                    )
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text('Part: ${videoCursor}', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  child: Center(
                                    child: _controller.value.isInitialized
                                        ? AspectRatio(
                                      aspectRatio: _controller.value.aspectRatio,
                                      child: VideoPlayer(_controller),
                                    )
                                        :
                                    Container(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(

                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: (){
                                              videoCursor -= 1;
                                              if(videoCursor < 0){
                                                //alert 처음 동영상 입니다.
                                                videoCursor += 1;
                                                print('처음');
                                                return;
                                              }else if(videoCursor > videoList.length){
                                                //alert 마지막 동영상 입니다.
                                                return;
                                              }else{
                                                _controller = VideoPlayerController.asset(videoList[videoCursor])
                                                  ..initialize().then((_) {
                                                    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                                    setState(() {});
                                                  });
                                              }
                                            },
                                            child: Text('이전 파트')
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: (){
                                              setState(() {
                                                _controller.value.isPlaying
                                                    ? _controller.pause()
                                                    : _controller.play();
                                              });
                                            },
                                            child: Icon(
                                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Container(
                                          child: ElevatedButton(
                                            onPressed: (){
                                              videoCursor += 1;
                                              if(videoCursor < 0){
                                                //alert 처음 동영상 입니다.
                                                return;
                                              }else if(videoCursor > videoList.length-1){
                                                //alert 마지막 동영상 입니다.
                                                videoCursor-=1;
                                                print('마지막');
                                                return;
                                              }else{
                                                _controller = VideoPlayerController.asset(videoList[videoCursor])
                                                  ..initialize().then((_) {
                                                    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                                    setState(() {});
                                                  });
                                              }
                                            },
                                            child: Text('다음 파트')
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              )
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),
              //채점표
              Container(
                height: 500.0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          renderTextFormField(
                            label: '음악성',
                            onSaved: (val) {
                              setState(() {
                                musicScore = val;
                              });
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: '테크닉',
                            onSaved: (val) {
                              setState(() {
                                techScore = val;
                              });
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: '소리',
                            onSaved: (val) {
                              setState(() {
                                soundScore = val;
                              });
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: '아티큘레이션',
                            onSaved: (val) {
                              setState(() {
                                articulation = val;
                              });
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          renderButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }


  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            hintText: '0~100 사이 점수를 입력해주세요',
          ),
        ),
        SizedBox(height: 5.0,),
      ],
    );
  }

  renderButton() {
    return ElevatedButton(
      onPressed: () async {
        if(formKey.currentState!.validate()){
          // validation 이 성공하면 true 가 리턴돼요!
          this.formKey.currentState?.save();

          int musicS = int.parse(musicScore);
          int techS = int.parse(techScore);
          int soundS = int.parse(soundScore);
          int articulationS = int.parse(articulation);

          print(musicS);
          print(techS);
          print(soundS);
          print(articulationS);

          if(musicS > -1 && musicS < 101
          && techS > -1 && techS < 101
          && soundS > -1 && soundS < 101
          && articulationS > -1 && articulationS < 101
          ){
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                title: Text('마지막으로 점수 확인 부탁드립니다!'),
                content: Text('${current_user_name}님\n'
                    '곡명: ${current_song_name}\n'
                    'part: ${current_song_data_name}\n'
                    '음악 점수: ${musicScore}\n'
                    '기술 점수: ${techScore}\n'
                    '소리 점수: ${soundScore}\n'
                    '아티큘레이션 점수: ${articulation}'),
                actions: [
                  ElevatedButton(onPressed: () async{
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        content: FutureBuilder(
                          future: saveData(name: current_user_name,
                              song_name:current_song_name,
                              song_part_name: current_song_data_name,
                              music_score: musicS,
                              tech_score: techS,
                              sound_score: soundS,
                              articulation: articulationS),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                             if(snapshot.hasData == false){
                               return CircularProgressIndicator();
                             }else{
                               return Text('저장완료!');
                             }
                          },
                        ),
                      );
                    });
                    //서버로 데이터 전송
                  }, child: Text('저장하기!'))
                ],
              );
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              //SnackBar 구현하는법 context는 위에 BuildContext에 있는 객체를 그대로 가져오면 됨.
                SnackBar(
                  content: Text('최소 0 최대 100 점수를 입력하셔야 합니다!'), //snack bar의 내용. icon, button같은것도 가능하다.
                  duration: Duration(seconds: 5), //올라와있는 시간
                  action: SnackBarAction( //추가로 작업을 넣기. 버튼넣기라 생각하면 편하다.
                    label: 'Undo', //버튼이름
                    onPressed: (){}, //버튼 눌렀을때.
                  ),
                )
            );
          }
        }

      },
      child: Text(
        '저장하기!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }


  //renderWidget
  Future<void> renderSongListWidget() async{
    songListWidget = [];
    for(int i =0;i<songList.length;i++){
      songListWidget.add(
          InkWell(
            onTap:(){

            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30.0,
              margin: EdgeInsets.only(left: 20.0,  right: 20.0),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.grey.shade400
                    )
                  )
              ),
              child: Text(songList[i], textAlign: TextAlign.center,),
            ),
          )
      );
    }
  }

  // 서버 데이터 통신
  Future<int?> saveData(
      {
    required String name,
        required String song_name,
        required String song_part_name,
        required int music_score,
        required int tech_score,
        required int sound_score,
        required int articulation
}
      ) async{
    Dio dio = Dio();

    var json_data = {
      'name' : name,
      'song_name' : song_name,
      'song_part_name': song_part_name,
      'music_score' : music_score,
      'tech_score'  : tech_score,
      'sound_score' : sound_score,
      'articulation' : articulation
    };
      final response = await dio.post('${MYSERVERIP}/store_score_data', data: json_data);
      return response.statusCode;
  }

}




