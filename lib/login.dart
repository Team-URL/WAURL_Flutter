import 'package:flutter/material.dart';
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

  Future<void> _login() async {// 로그인 로직
    String email = _emailController.text;
    String password = _passwordController.text;

    bool isPass = await fetchInfo(email, password);
    if(isPass){
      print('로그인 성공');
    }else{
      print('로그인 실패');
    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
  }

  void _signup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(// 로그인 화면 appBar 불필요
      body: Padding(

        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),

            SizedBox(height: 70),

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

            SizedBox(height: 30),

            TextField(
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
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2EC6F3)), // 파란색 바탕
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // 버튼 모서리 둥글기 조절
                  ),
                ),
              ),
              child: Text('로그인'),
            ),

            SizedBox(height: 10),

            TextButton(
              onPressed: _signup,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 하얀색 바탕
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // 버튼 모서리 둥글기 조절
                  ),
                ),
              ),
              child: Text('회원가입', style: TextStyle(color: Color(0xff2EC6F3)),),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: LoginScreen()));
