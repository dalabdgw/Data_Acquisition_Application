import 'package:data_annotation_page/screen/data_annotation_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart' as gX;
import 'package:data_annotation_page/server_info.dart';

class ConfirmScreen extends StatefulWidget {
  String song_name = '';
  int part_num = 0;
  String user_id = '';
  int musicScore = 0;
  int techScore = 0;
  int soundScore = 0;
  int articulationScore = 0;

  ConfirmScreen({Key? key,
    required String song_name,
    required int part_num,
    required String user_id,
    required int musicScore,
    required int techScore,
    required int soundScore,
    required int articulationScore,
  }) : super(key: key){
    this.song_name = song_name;
    this.part_num = part_num;
    this.user_id = user_id;
    this.musicScore = musicScore;
    this.techScore = techScore;
    this.soundScore = soundScore;
    this.articulationScore = articulationScore;
  }


  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState(
    song_name,
      part_num,
      user_id,
      musicScore,
    techScore,
    soundScore,
    articulationScore
  );
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  String song_name = '';
  int part_num = 0;
  String user_id = '';
  int musicScore = 0;
  int techScore = 0;
  int soundScore = 0;
  int articulationScore = 0;

  _ConfirmScreenState(
      String song_name,
      int part_num,
      String user_id,
      int musicScore,
      int techScore,
      int soundScore,
      int articulationScore,
      ){
    this.song_name = song_name;
    this.part_num = part_num;
    this.user_id = user_id;
    this.musicScore = musicScore;
    this.techScore = techScore;
    this.soundScore = soundScore;
    this.articulationScore = articulationScore;
  }
  final uidController = gX.Get.put(UidController());
  @override
  Widget build(BuildContext context) {

    //chart design
    List<ChartData> chartData = [
      ChartData('음악', musicScore as double),
      ChartData('기술', techScore as double),
      ChartData('소리', soundScore as double),
      ChartData('아티큘레이션', articulationScore as double)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x0000000),
        shadowColor:  Color(0x0000000),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text('점수를 한번 더 확인해주세요!', style: TextStyle(fontSize: 20.0),),
              ),
              Container(
                height: 500.0,
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
                        isVisible: true
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black
                  ),
                  onPressed: () async{
                    saveReviewData(
                        song_name,
                        part_num.toString(),
                        user_id,
                        musicScore.toString(),
                        techScore.toString(),
                        soundScore.toString(),
                        articulationScore.toString(),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('저장'),
                ),
              ),
            ],
          ),
        )
      ),
    );
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
    print(user_id);
    Response response = await dio.post(AWSRDSIP+'/input_review_data', data: json_data);

    dio.close();
    return response.statusCode;
  }

  @override
  void initState(){
    user_id = uidController.getUid();
    super.initState();
  }
}
class ChartData {
  ChartData(this.x, this.y);
  String x;
  double y;
}
