// define button and appbar , etc..

import 'package:flutter/material.dart';

renderLeadingAppButton(){
  return ElevatedButton(
    onPressed: (){},
    child: Image.asset('asset/image/logo.jpeg', fit: BoxFit.fill,),
  );
}

renderSongSelectAlert(String text, BuildContext context){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title:Text('선택하신 곡'),
      content: Text(text),
      actions: [
        IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.cancel_outlined), color: Colors.red,)
      ],
    );
  });

}