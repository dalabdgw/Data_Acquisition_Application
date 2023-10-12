import 'package:flutter/material.dart';

class EnrollSongScreen extends StatefulWidget {
  const EnrollSongScreen({Key? key}) : super(key: key);

  @override
  State<EnrollSongScreen> createState() => _EnrollSongScreenState();
}

class _EnrollSongScreenState extends State<EnrollSongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
            child: Column(
              children: [

              ],
            ),
        ),
      ),
    );
  }
}
