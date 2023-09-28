import 'package:data_annotation_page/main_function/main_function_screen.dart';
import 'package:data_annotation_page/screen/data_annotation_screen.dart';
import 'package:data_annotation_page/screen/home_page.dart';
import 'package:data_annotation_page/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");	// for api_key

  runApp(
    MaterialApp(
      home: DataAnnotationScreen(),
    )
  );
}
