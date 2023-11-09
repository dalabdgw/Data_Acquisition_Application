import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: MediaQuery.of(context).size.width > 900.0 ?
          Row( // 웹 의 경우
            children: [
              Expanded(
                flex: 7,
                child: Container(
                    padding: EdgeInsets.all(30.0),
                    color: Colors.blue,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text('연주를 전문가에게 평가 받아보세요!', style: TextStyle(fontSize: 40.0),),
                          )
                        ],
                      ),
                    )
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                            color: Colors.red,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 100.0,),
                                  Container(
                                    width: 200.0,
                                    height: 50.0,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(height: 10.0,),
                                  Container(
                                    width: 200.0,
                                    height: 50.0,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(height: 10.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(onPressed: (){}, child: Text('로그인')),
                                      SizedBox(width: 5.0,),
                                      ElevatedButton(onPressed: (){}, child: Text('회원가입')),
                                    ],
                                  ),
                                  SizedBox(height: 50.0,),

                                ],
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ) : Column( // 모바일의 경우
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(

                ),
              ),
            ],
          ),
        ),
      )
    );

  }
}
