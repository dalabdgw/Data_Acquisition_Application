import 'package:async/async.dart';
import 'package:data_annotation_page/screen/confirm_screen.dart';
import 'package:data_annotation_page/screen/data_annotation_connection_func.dart';
import 'package:data_annotation_page/screen/enroll_song_screen.dart';
import 'package:data_annotation_page/screen/review_data_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:video_player/video_player.dart';

import '../server_info.dart';

class DataAnnotationScreen extends StatefulWidget {
  const DataAnnotationScreen({Key? key}) : super(key: key);

  @override
  State<DataAnnotationScreen> createState() => _DataAnnotationScreenState();
}

class _DataAnnotationScreenState extends State<DataAnnotationScreen> {

  late Future myFuture;
  late Future song_list_future;

  Dio dio = Dio();

  late VideoPlayerController _videoController; // for video player

  List<dynamic> video_part = [];

  // 곡 모음 리스트
  List<dynamic> song_name_list = [];

  int videoCursor = 0;
  // annotation table!
  final formKey = GlobalKey<FormState>();

  // 데이터 베이스에 저장할 내용 입력하기  -> 폼 데이터
  String current_user_id = 'pms1001'; // 이름
  String current_song_name = 'Chopinetudedae'; // 현재 곡 이름

  String musicScore = '';
  String techScore = '';
  String soundScore = '';
  String articulation = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          renderDescription();
        },
        backgroundColor: Colors.black,
        child: Text('설명서'),
      ),
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200.0),
            child: Image.asset('asset/image/logo.jpeg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        title: Text('REVIEW SYSTEM\n${current_song_name}', style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0x00000000),
        shadowColor: Color(0x00000000),
        actions: [
          //for end drawer setting
          Builder( // for enddrawer setting
            builder: (context) => IconButton(
              icon: Icon(Icons.library_music_sharp, color: Colors.green,),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: song_list_future,
          builder: (context, snapshot1){
            if(snapshot1.hasData){
              song_name_list = snapshot1.data;
              return FutureBuilder(
                future: myFuture,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    video_part = snapshot.data;
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: MediaQuery.of(context).size.width > 700.0 ?
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: renderVideoPlayer(),
                              ),
                              Expanded(
                                flex: 4,
                                child: renderAnnotationPaper(),
                              )
                            ],
                          ):
                          Column(
                            children: [
                              renderVideoPlayer(),
                              renderAnnotationPaper(),
                            ],
                          ),
                        )
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                },
              );
            }else{
              return CircularProgressIndicator();
            }
          },
        )
      ),
      endDrawer: renderDrawer(),

    );
  }

  renderDrawer(){

    final List<String> song_list = [];

    for(int i=0;i<song_name_list.length;i++){
      song_list.add(song_name_list[i].toString());
    }
    setState(() {

    });
    return Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Container(
                child: DrawerHeader(
                  child: Text('~~~님'),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ReviewDataScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text('내 평가 확인하기'),
                  )
                )
              )
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Song List', textAlign: TextAlign.start, style: TextStyle(fontSize: 20.0),),
              ),
            ),
            Expanded(
              flex: 80,
              child: Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: song_name_list.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){
                        current_song_name = song_name_list[index];
                        print(current_song_name);
                        setState(() {
                          myFuture = loadPartVideoList(current_song_name);
                          Navigator.pop(context);
                          _videoController = VideoPlayerController.asset('asset/video/bee.mp4')
                            ..initialize().then((_) {
                              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                              setState(() {});
                            });
                          videoCursor = 0;
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Colors.grey.shade300
                                  )
                              )
                          ),
                          height: 50,
                          child: Center(
                            child: Text('곡명: ${song_name_list[index]}'),
                          )
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }
  // 비디오 위젯 렌더링!
  renderVideoPlayer(){
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black,
          ),
          margin: EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.width > 700.0 ? MediaQuery.of(context).size.height -100 : 250.0,
          width: MediaQuery.of(context).size.width,
          child: _videoController.value.isInitialized ? VideoPlayer(_videoController,) : Center(child: CircularProgressIndicator(),),
        ),
        Positioned(
          bottom: 30,
          left: 30,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
                backgroundColor: Colors.white
            ),
            onPressed: (){
              videoCursor -= 1;
              if(videoCursor < 0){
                //alert 처음 동영상 입니다.
                videoCursor += 1;
                print('처음');
                return;
              }else if(videoCursor > video_part.length){
                //alert 마지막 동영상 입니다.
                return;
              }else{
                _videoController = VideoPlayerController.networkUrl(Uri.parse(video_part[videoCursor]['part_url']))
                  ..initialize().then((_) {
                    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                    setState(() {});
                  });
              }
            },
            child: Text('뒤로', style: TextStyle(color: Colors.black),),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              onPrimary: Colors.black,
            ),
            onPressed: (){
              videoCursor += 1;
              if(videoCursor < 0){
                //alert 처음 동영상 입니다.
                return;
              }else if(videoCursor > video_part.length-1){
                //alert 마지막 동영상 입니다.
                videoCursor-=1;
                print('마지막');
                return;
              }else{
                _videoController = VideoPlayerController.networkUrl(Uri.parse(video_part[videoCursor]['part_url']))
                  ..initialize().then((_) {
                    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                    setState(() {});
                  });
              }
            },
            child: Text('다음', style: TextStyle(color: Colors.black),),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 100,
          right: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
              backgroundColor: Colors.white
            ),
            onPressed: (){
              if(videoCursor==0){
                _videoController = VideoPlayerController.networkUrl(Uri.parse(video_part[videoCursor]['part_url']))
                  ..initialize().then((_) {
                    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                    setState(() {});
                  });
              }
              _videoController.value.isPlaying
                  ? _videoController.pause()
                  : _videoController.play();
              setState(() {

              });
            },
            child: _videoController.value.isPlaying ? Text('정지', style: TextStyle(color: Colors.black),) : Text('재생', style: TextStyle(color: Colors.black),),
          ),

        ),
        Positioned(
          left: 100,
          right: 100,
          top: 20,
          child: Text('part${videoCursor}', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white),),
        )
      ],
    );
  }
  // 채점 위젯 렌더링!
  renderAnnotationPaper(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black)
      ),
      margin: EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.width > 700.0 ?MediaQuery.of(context).size.height -100 : 450.0,
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
    );
  }

  //form 필드
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
  // form필드 버튼
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

          if(musicS > -1 && musicS < 101
              && techS > -1 && techS < 101
              && soundS > -1 && soundS < 101
              && articulationS > -1 && articulationS < 101
          ){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>ConfirmScreen(
              song_name: current_song_name,
              part_num: videoCursor,
              user_id: 'pms1001',
              musicScore: musicS,
              techScore: techS,
              soundScore: soundS,
              articulationScore: articulationS,
            )));
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
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black
      ),
      child: Text(
        '저장하기!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  renderDescription(){

    int cursor = 0;

    List<String> description_list = [
      'asset/image/description_img/1.png',
      'asset/image/description_img/2.png',
      'asset/image/description_img/3.png',
      'asset/image/description_img/4.png',
      'asset/image/description_img/1.png',
      'asset/image/description_img/1.png',
    ];

    showDialog(context: context, builder: (BuildContext context){
      return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
        return AlertDialog(
          title: Text('리뷰 시스템 사용법'),
          content: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(description_list[cursor]),
                    fit: BoxFit.fitWidth
                )
            ),
          ),
          actions: [
            ElevatedButton(onPressed: (){
              if(cursor == 0){
                print('처음');
              }else{
                cursor-=1;
              }
              setState(() {

              });
            }, child: Text('이전')),
            ElevatedButton(onPressed: (){
              if(cursor > description_list.length -1){
                print('마지막');
              }else{
                cursor+=1;
              }
              setState(() {

              });
            }, child: Text('다음'))
          ],
        );
      });
    });
  }

  @override
  void dispose(){
    super.dispose();

  }
  @override
  void initState() {
    song_list_future = loadSongList();
    myFuture = loadPartVideoList(current_song_name);

    _videoController = VideoPlayerController.asset('asset/video/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }


}
