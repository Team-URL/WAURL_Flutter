import 'package:flutter/material.dart';
import 'package:who_are_url/searchingPage.dart';
import 'join.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Future<bool> fetchInfo(String email, String password) async {
  var url = Uri.http(
      '13.124.151.213:8080', '/users/login', {'email': email, 'passWord': password});
  // localhost:8080/users/join?email=123@naver.com&passoword=1234

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"email": email, "passWord": password}),
  );

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답했다');
    print(json.decode(response.body));
    return json.decode(response.body);
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('API를 불러오는데 실패했습니다');
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      bool isPass = await fetchInfo(email, password);
      if (isPass) {
        print('로그인 성공');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SearchingPage()), (route) => false);
      } else {
        print('로그인 실패');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('email과 password가 일치하지 않습니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('확인', style: TextStyle(color: Color(0xff4baf96))),
                ),
              ],
            );
          },
        );
      }
    } else {
      print('입력되지 않은 항목이 있습니다.');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('입력되지 않은 항목이 있습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인', style: TextStyle(color: Color(0xff4baf96))),
              ),
            ],
          );
        },
      );
    }
  }


  void _signup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(// 로그인 화면 appBar 불필요
      body: SingleChildScrollView(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70,),
            Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),

              SizedBox(height: 80,),

              TextFormField(
                controller: _emailController,
                textAlign: TextAlign.left,
                cursorColor: Colors.grey,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    gapPadding: 15,
                  ),

                  contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  hintText: 'email',
                  hintStyle: TextStyle(
                    color: Color(0xff868686),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                textAlign: TextAlign.left,
                cursorColor: Colors.grey,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey),
                    gapPadding: 15,
                  ),

                  contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  hintText: 'password',
                  hintStyle: TextStyle(
                    color: Color(0xff868686),
                  ),
                ),
                obscureText: true,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                  backgroundColor: Color(0xff4baf96), // 파란색 바탕
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // 버튼 모서리 둥글기 조절
                  ),
                ),
                child: Text('로그인', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color:Colors.white),),
              ),

              SizedBox(height: 5),

              TextButton(
                onPressed: _signup,
                child: Text('회원가입', style: TextStyle(color: Color(0xff4baf96), fontSize: 18,fontWeight: FontWeight.w600),),
              ),
            ],
          ),
        ),
    );
  }
}

void main() => runApp(MaterialApp(home: LoginScreen()));
