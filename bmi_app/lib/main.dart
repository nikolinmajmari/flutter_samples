import 'package:bmi_app/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'input_page.dart';

void main() {
  runApp(BmiCalculator());
}

class BmiCalculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.blueAccent,
          appBarTheme: AppBarTheme(
            color:Color(0xffe87d13),
          ),
          backgroundColor:  Colors.lightBlueAccent[400],
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Color(0xffffe8bf),
          primaryTextTheme: TextTheme(
            caption: TextStyle(color: Colors.black),
            bodyText1: TextStyle(color: Colors.black)
          )
        ),
        routes: {
          '/': (context)=>InputPage(),
          '/result':(context)=>ResultPage(),
        }
    );
  }
}

