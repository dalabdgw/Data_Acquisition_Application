import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:data_annotation_page/server_info.dart';
import 'confirm_screen.dart';

class ReviewDataScreen extends StatefulWidget {
  const ReviewDataScreen({Key? key}) : super(key: key);

  @override
  State<ReviewDataScreen> createState() => _ReviewDataScreenState();
}

class _ReviewDataScreenState extends State<ReviewDataScreen> {

  late Future load_user_review;
  late Future load_part_review;

  List<String> song_name_list = [
  ];

  String current_song_name = 'Chopinetudedae';


  int index = 0;
  int part_cursor = 0;
  int? last_index=0;

  // for chart design
  ChartData c1 = ChartData('음악', 0);
  ChartData c2 = ChartData('기술', 0);
  ChartData c3 = ChartData('소리', 0);
  ChartData c4 = ChartData('아티큘레이션', 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: Text('내가 평가한 곡 리스트', style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0x00000000),
        shadowColor: Color(0x00000000),
      ),
      body: FutureBuilder(
        future: load_user_review,
        builder: (context, snapshot){
          if(snapshot.hasData){
            song_name_list = [];
              List<dynamic> tempList = snapshot.data;
              for(int i=0;i<tempList.length;i++){
                song_name_list.add(tempList[i].toString());
              }
            return SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: song_name_list.length,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      onTap: (){
                        current_song_name = song_name_list[index];
                        setState(() {
                          load_part_review = loadReviewPartData('pms1001', current_song_name);
                        });

                        renderReviewDataAlert(
                          song_name_list[index]
                        );
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
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      )
    );
  }

  @override
  void initState(){
    load_user_review = loadReviewData('pms1001');
    load_part_review = loadReviewPartData('pms1001', current_song_name);
    super.initState();
  }

  renderReviewDataAlert(
      String song_name,
      ){


    List<dynamic>? created_date = [];
    List<dynamic>? music_score = [];
    List<dynamic>? tech_score = [];
    List<dynamic>? sound_score = [];
    List<dynamic>? articulation_score = [];


    //chart design

    List<ChartData> chartData = [
      c1,c2,c3,c4
    ];

    showDialog(context: context, builder: (BuildContext context){

      // 파트 커서 초기화
      part_cursor = 0;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return AlertDialog(

              content: FutureBuilder(
                future: load_part_review,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    Map<dynamic, List<dynamic>> map = snapshot.data;

                    // 데이터 분할
                    created_date = map['created_date_list'];
                    music_score = map['music_score_list'];
                    tech_score = map['tech_score_list'];
                    sound_score = map['sound_score_list'];
                    articulation_score = map['articulation_score_list'];


                    last_index = (music_score!.length - 1)!;
                    c1.y = double.parse(music_score![part_cursor].toString());
                    c2.y = double.parse(tech_score![part_cursor].toString());
                    c3.y = double.parse(sound_score![part_cursor].toString());
                    c4.y = double.parse(articulation_score![part_cursor].toString());


                    return Container(
                      height: 500.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width,
                              child: Text('곡명: ${song_name} , 파트: ${part_cursor}', style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,)
                          ),
                          Container(
                            height: 400.0,
                            width: 400.0,
                            child: SfCircularChart(
                              tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                  format: 'point.x :  point.y점'
                              ),
                              legend: Legend(
                                isVisible: true,
                                position: LegendPosition.bottom,
                                overflowMode: LegendItemOverflowMode.wrap,
                              ),
                              series: <CircularSeries>[
                                RadialBarSeries<ChartData, String>(
                                    maximumValue: 99.9,
                                    gap: '5',
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    // Corner style of radial bar segment
                                    cornerStyle: CornerStyle.bothCurve,
                                    enableTooltip: true,
                                    dataLabelSettings: DataLabelSettings(

                                    ),
                                    radius: '100%',
                                    useSeriesColor: true,
                                    trackOpacity: 0.3
                                )
                              ],
                              annotations: [
                                CircularChartAnnotation(
                                    widget: ClipRRect(
                                      borderRadius: BorderRadius.circular(200.0),
                                      child: Image.asset('asset/image/logo.jpeg',
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    angle: 0,
                                    radius: '0%',
                                    height: '85%',
                                    width: '85%'
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    if(part_cursor == index){
                                      print('처음');
                                    }else{
                                      part_cursor -=1;
                                      c1.y = double.parse(music_score![part_cursor].toString());
                                      c2.y = double.parse(tech_score![part_cursor].toString());
                                      c3.y = double.parse(sound_score![part_cursor].toString());
                                      c4.y = double.parse(articulation_score![part_cursor].toString());
                                      print(part_cursor);
                                    }
                                  });
                                }, child: Text('이전${part_cursor}'), style: ElevatedButton.styleFrom(backgroundColor: Colors.black),),
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    if(part_cursor == last_index){
                                      print('마지막');
                                    }else{
                                      c1.y = double.parse(music_score![part_cursor].toString());
                                      c2.y = double.parse(tech_score![part_cursor].toString());
                                      c3.y = double.parse(sound_score![part_cursor].toString());
                                      c4.y = double.parse(articulation_score![part_cursor].toString());
                                      part_cursor+=1;
                                    }
                                  });
                                }, child: Text('다음${part_cursor}'),style: ElevatedButton.styleFrom(backgroundColor: Colors.black),),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                },
              )
          );
        },
      );
    });
  }
  // 평가 데이터를 조회하기
  Future<List> loadReviewData(user_id) async {

    Dio dio = Dio();

    Response response = await dio.get(AWSRDSIP+'/load_user_review', queryParameters: {'user_id' : user_id});
    List<dynamic> responseBody = response.data;
    dio.close();
    return responseBody;
  }
  Future<Map<dynamic, List>> loadReviewPartData(user_id, song_name) async {

    Dio dio = Dio();

    Response response = await dio.get(AWSRDSIP+'/load_part_review', queryParameters: {'user_id' : user_id, 'song_name' : song_name});

    Map<dynamic, List<dynamic>> map = Map.from(response.data);

    dio.close();
    return map;
  }
}
