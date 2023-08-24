import 'package:flutter/material.dart';
import 'package:who_are_url/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhoAreURL',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff4baf96
            , {
          50: Color(0xff4baf96
          ),
          100: Color(0xff4baf96
          ),
          200: Color(0xff4baf96
          ),
          300: Color(0xff4baf96
          ),
          400: Color(0xff4baf96
          ),
          500: Color(0xff4baf96
          ),
          600: Color(0xff4baf96
          ),
          700: Color(0xff4baf96
          ),
          800: Color(0xff4baf96
          ),
          900: Color(0xff4baf96
          ),
        }),
      ),
      home: LoginScreen(),
    );
  }
}