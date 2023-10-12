import 'package:data_annotation_page/screen/data_annotation_screen.dart';
import 'package:flutter/material.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  //await dotenv.load(fileName: ".env");	// for api_key



  runApp(
    MaterialApp(
      home: DataAnnotationScreen(),
    )
  );
}
