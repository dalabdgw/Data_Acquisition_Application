import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                renderTextFormField(
                  label: '이름',
                  onSaved: (val) {},
                  validator: (val) {
                    if(val.length < 1) {
                      return '이름은 필수사항입니다.';
                    }

                    if(val.length < 2) {
                      return '이름은 두글자 이상 입력 해주셔야합니다.';
                    }

                    return null;
                  },
                ),
                renderTextFormField(
                  label: '이메일',
                  onSaved: (val) {
                  },
                  validator: (val) {
                    if(val.length < 1) {
                      return '이메일은 필수사항입니다.';
                    }

                    if(!RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(val)){
                      return '잘못된 이메일 형식입니다.';
                    }

                    return null;
                  },
                ),
                renderTextFormField(
                  label: '비밀번호',
                  onSaved: (val) {},
                  validator: (val) {
                    if(val.length < 1) {
                      return '비밀번호는 필수사항입니다.';
                    }

                    if(val.length < 8){
                      return '8자 이상 입력해주세요!';
                    }
                    return null;
                  },
                ),
                renderTextFormField(
                  label: '주소',
                  onSaved: (val) {},
                  validator: (val) {
                    if(val.length < 1) {
                      return '주소는 필수사항입니다.';
                    }
                    return null;
                  },
                ),
                renderTextFormField(
                  label: '닉네임',
                  onSaved: (val) {},
                  validator: (val) {
                    if(val.length < 1) {
                      return '닉네임은 필수사항입니다.';
                    }
                    if(val.length < 8) {
                      return '닉네임은 8자 이상 입력해주세요!';
                    }
                    return null;
                  },
                ),
                renderButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        ),
        Container(height: 16.0),
      ],
    );
  }

  renderButton() {
    return ElevatedButton(
      onPressed: () async {
        if(formKey.currentState!.validate()){
          // validation 이 성공하면 true 가 리턴돼요!

        }

      },
      child: Text(
        '저장하기!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
