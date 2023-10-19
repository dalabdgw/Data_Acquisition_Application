import 'package:data_annotation_page/screen/confirm_screen.dart';
import 'package:data_annotation_page/screen/review_data_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';
import 'package:data_annotation_page/component.dart';
import 'package:data_annotation_page/server_info.dart';
import 'package:get/get.dart' as gX;

class DataAnnotationScreen extends StatefulWidget {
  const DataAnnotationScreen({Key? key}) : super(key: key);

  @override
  State<DataAnnotationScreen> createState() => _DataAnnotationScreenState();
}

class _DataAnnotationScreenState extends State<DataAnnotationScreen> {

  final GlobalKey<NavigatorState> key =
  new GlobalKey<NavigatorState>();

  late Future myFuture;
  late Future song_list_future;

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

            if(snapshot1.data != null){

              song_name_list = snapshot1.data;

              return FutureBuilder(
                future: myFuture,
                builder: (context, snapshot){
                  if(snapshot.data != null){

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
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    children: [
                      Text('페이지 로딩 중'),
                      SizedBox(height: 10.0,),
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              );
            }
          },
        )
      ),
      endDrawer: Drawer(
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

                          //알림 창 뜨게하기
                          renderSongSelectAlert(current_song_name, context);
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
      ),
      key: key,
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
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Text('채점표', style: TextStyle(fontSize: 20.0),),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
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
                  )
                ),
              ),
            ),
          ),
        ],
      )
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

    current_song_name = 'Chopinetudedae';
    myFuture = loadPartVideoList(current_song_name);

    _videoController = VideoPlayerController.asset('asset/video/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // your method where use the context
      // Example navigate:
      showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){


        bool _isLoginPaged = true;

        bool _isGenderCheckGirl = false;
        bool _isGenderCheckMan = true;

        String? departmentDropdownvalue = "음악과";

        String? jobDropdownValue = "학생";

        bool _isClickPhoneNumber = false;

        String user_name = '';
        String ph_num = '';

        TextEditingController _nameController = TextEditingController();
        TextEditingController _phnumController = TextEditingController();

        return gX.GetBuilder(
          init: UidController(),
          builder: (_)=>StatefulBuilder(builder: (BuildContext context, StateSetter setState){
            return AlertDialog(
              title: Text('환영합니다!'),
              content: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                height: _isLoginPaged ? 200.0 : 400.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.0,
                      child: _isLoginPaged ? Text('곡 평가를 위해 로그인 해주세요!') :Text('곡 평가를 위해 정보를 등록해주세요!'),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      height: _isLoginPaged? 150.0:350.0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200.0,
                                child: TextField(
                                  controller: _nameController,
                                  onChanged: (text){
                                    setState((){
                                      user_name = text;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      label: Text('이름')
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200.0,
                                child: TextField(
                                  controller: _phnumController,
                                  onTap: (){
                                    if(_isClickPhoneNumber != true && _isLoginPaged != true){
                                      _isClickPhoneNumber = true;
                                      showDialog(context: context, builder: (builder){
                                        return AlertDialog(
                                          content: Text('전화번호를 잘 기입하셔야 상품을 드려요!'),
                                        );
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                      label: Text('전화번호(xxx-xxxx-xxxx)')
                                  ),
                                  onChanged: (text){
                                    setState((){
                                      ph_num = text;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          AnimatedContainer(
                              height: _isLoginPaged? 0 :  190.0,
                              duration: Duration(milliseconds: 1000),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child:  Column(
                                  children: [
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('남'),
                                        Checkbox(value: _isGenderCheckMan, onChanged: (value){
                                          setState(() {
                                            if(_isGenderCheckMan){
                                            }else{
                                              _isGenderCheckMan = true;
                                              _isGenderCheckGirl = false;
                                            }
                                          });
                                        }),
                                        Text('여'),
                                        Checkbox(value: _isGenderCheckGirl, onChanged: (value){
                                          setState(() {
                                            if(_isGenderCheckGirl){
                                            }else{
                                              _isGenderCheckMan = false;
                                              _isGenderCheckGirl = true;
                                            }
                                          });
                                        })
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('학과 선택'),
                                        DropdownButton(
                                          value:departmentDropdownvalue,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 8,
                                          underline: Container(
                                            height: 2,
                                            color: Colors.cyan,
                                          ),
                                          onChanged: (newValue){
                                            departmentDropdownvalue = newValue;
                                            setState((){});
                                          },
                                          items: <String>[
                                            '음악과',
                                            '성악과'
                                          ].map<DropdownMenuItem<String>>((String value){
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('학과 선택'),
                                        DropdownButton(
                                          value:jobDropdownValue,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 8,
                                          underline: Container(
                                            height: 2,
                                            color: Colors.cyan,
                                          ),
                                          onChanged: (newValue2){
                                            jobDropdownValue = newValue2;
                                            setState((){});
                                          },
                                          items: <String>[
                                            '학생',
                                            '대학생',
                                            '교수'
                                          ].map<DropdownMenuItem<String>>((String value){
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        backgroundColor: Colors.white
                    ),
                    onPressed: () async{

                  user_name = 'Unknown';
                  _.setUid(user_name);
                  Navigator.pop(context);


                }, child: Text('그냥 하기')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        backgroundColor: Colors.white
                    ),
                    onPressed: () async{

                  Dio dio = Dio();

                  String gender = '';

                  if(user_name == ''){
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        content: Text('이름을 입력해주세요!'),
                      );
                    });
                  }else {
                    if (ph_num == '') {
                      showDialog(
                          context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('전화번호를 입력해주세요!'),
                        );
                      });
                    } else {
                      if(_isLoginPaged){
                        try{
                          Response res = await dio.get(AWSRDSIP+'/load_user', queryParameters: {
                            'user_name' : user_name,
                            'ph_num' : ph_num
                          });
                          if(res.statusCode==200){
                            _.setUid(user_name);
                            Navigator.pop(context);
                            showDialog(context: context, builder: (builder) {
                              return AlertDialog(
                                content: Text('안녕하세요 ${user_name}님!'),
                              );
                            });
                          }else{ // 로그인 실패 했을 때 회원가입 절차를 위해 나머지를 보여준다.
                            _isLoginPaged = false;
                            showDialog(context: context, builder: (builder) {
                              return AlertDialog(
                                content: Text('처음오세요? ${user_name}님?\n 등록을 진행해주세요!'),
                              );
                            });
                            setState((){});
                          }
                        }catch(e){
                          showDialog(context: context, builder: (builder) {
                            return AlertDialog(
                              content: Text('서버가 바빠요! 조금만 기다려주세요!'),
                            );
                          });
                        }
                      }else{
                        if (_isGenderCheckGirl == true) {
                          gender = '여';
                        } else {
                          gender = '남';
                        }
                        var jsonData = {
                          'user_id': user_name,
                          'ph_num': ph_num,
                          'gender': gender,
                          'department': departmentDropdownvalue,
                          'job': jobDropdownValue
                        };
                        print(jsonData);

                        try {
                          Response res = await dio.post(AWSRDSIP+'/create_user', data: jsonData);

                          if (res.statusCode == 200) {
                            _.setUid(user_name);
                            dio.close();
                            Navigator.pop(context);
                          } else {
                            showDialog(context: context, builder: (builder) {
                              return AlertDialog(
                                content: Text('서버가 바빠요! 조금만 기다려주세요!'),
                              );
                            });
                          }
                        }
                        catch (e) {
                          showDialog(context: context, builder: (builder) {
                            return AlertDialog(
                              content: Text('서버가 바빠요! 조금만 기다려주세요!'),
                            );
                          });
                        }
                      }
                    }
                  }
                }, child: _isLoginPaged ? Text('로그인') :Text('등록하기!'))
              ],
            );
          }),
        );
      });
    });
  }





  // 서버 곡 리스트를 불러온다.
  Future<List> loadSongList() async {

    print('호출');
    Dio dio = Dio();

    Response response = await dio.get(AWSRDSIP+'/load_song_list');

    List<dynamic> responseBody = response.data;
    dio.close();
    return responseBody;
  }
// 곡에 대한 part 동영상을 불러온다.
  Future<List> loadPartVideoList(song_name) async {
    print('호출');
    Dio dio = Dio();

    Response response = await dio.get(AWSRDSIP+'/load_song_part_list',queryParameters: {'song_name' : song_name});
    List<dynamic> responseBody = response.data;
    dio.close();
    return responseBody;
  }

//평가 데이터 자세히 조회하기
  Future<Map<dynamic, List>> loadReviewPartData(user_id, song_name) async {

    Dio dio = Dio();

    Response response = await dio.get(AWSRDSIP+'/load_part_review', queryParameters: {'user_id' : user_id, 'song_name' : song_name});

    Map<dynamic, List<dynamic>> map = Map.from(response.data);

    dio.close();
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
      dio.close();
      return 200;
    }else{
      dio.close();
      return response.statusCode;
    }
  }

}

class UidController extends gX.GetxController{
  String uid = '';

  String getUid(){
    return uid;
  }
  void setUid(String uid){
    this.uid = uid;
  }
}