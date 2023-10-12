import 'package:data_annotation_page/server_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataCheckPage extends StatefulWidget {
  const DataCheckPage({super.key});

  @override
  State<DataCheckPage> createState() => _DataCheckPageState();
}

class _DataCheckPageState extends State<DataCheckPage> {

  String myData = '';

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: load_piano_data(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.connectionState != ConnectionState.done){
              return CircularProgressIndicator();
            }else{
              return Text(myData);
            }
          },
        ),
      ),
    );
  }

  Future<String> load_piano_data() async{
    Dio dio = Dio();
    final res = await dio.get('${AWSEC2IP}/get_score_data', queryParameters: {'name' :'박민서'});

    for(int i =0;i<res.data.length;i++){
      for(int j=0;j<res.data[0].length;j++){
        myData += '${res.data[i][j]}';
      }
      myData += '\n';
    }
    return res.statusCode.toString();
  }
}
