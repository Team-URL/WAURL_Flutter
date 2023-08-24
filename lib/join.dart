import 'package:flutter/material.dart';
import 'login.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
 @override
 _SignUpScreenState createState() => _SignUpScreenState();
}

Future<bool> fetchInfo(String email, String password) async {
 var url = Uri.http(
     '13.124.151.213:8080', '/users/join', {'email': email, 'passWord': password});
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

class _SignUpScreenState extends State<SignUpScreen> {
 TextEditingController _emailController = TextEditingController();
 TextEditingController _passwordController = TextEditingController();
 TextEditingController _chekPasswordController = TextEditingController();

 Future<void> _signup() async {
  String email = _emailController.text;
  String password = _passwordController.text;
  String chekPassword = _chekPasswordController.text;

  if (password == chekPassword) {
   // 비밀번호 일치
   bool isPass = await fetchInfo(email, password);
   if(isPass){
    print('회원가입 성공');
    Navigator.push(// 성공하는 경우만 로그인 페이지로 이동
        context,
        MaterialPageRoute(builder: (context) => LoginScreen())
    );
   }else{//////////// 로그인 페이지로 넘어감 ㅜㅜㅜ ////////////////////////////////////////////////
    print('회원가입 실패');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('이미 사용중인 아이디입니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인', style: TextStyle(color: Color(0xff2EC6F3))),
            ),
          ],
        );
      },
    );
   }
   // true일 때 회원가입되어 로그인 페이지로 이동
  } else {
    // 비밀번호 불일치
   showDialog(
    context: context,
    builder: (context) {
     return AlertDialog(
      content: Text('비밀번호를 확인해주세요.'),
      actions: [
       TextButton(
        onPressed: () {
         Navigator.pop(context);
        },
        child: Text('확인', style: TextStyle(color: Color(0xff2EC6F3))),
       ),
      ],
     );
    },
   );
  }
 }

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   body: SingleChildScrollView(
    padding: const EdgeInsets.all(50),
    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
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
         )
      ),

      SizedBox(height: 10),

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
           hintText: 'Password',
           hintStyle: TextStyle(
             color: Color(0xff868686),
           ),
         ),
         obscureText: true,
       ),

       SizedBox(height: 10),

      TextField(
       controller: _chekPasswordController,
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
          hintText: 'Password 확인',
          hintStyle: TextStyle(
            color: Color(0xff868686),
          ),
        ),
        obscureText: true,
      ),

      SizedBox(height: 30),

      ElevatedButton(
       onPressed: _signup,
       style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff2EC6F3)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
         RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
         )
        )
       ),
       child: Text('회원가입'),
      ),
     ],
    ),
   ),
  );
 }
}
void main() => runApp(MaterialApp(home: SignUpScreen()));
