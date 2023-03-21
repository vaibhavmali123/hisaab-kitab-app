import 'package:flutter/material.dart';
import 'package:hisab_kitab/app/views/DashBoard.dart';

import '../feature/onboarding/SplashScreen.dart';

class MyApp extends StatelessWidget{
  @override

  Widget build(BuildContext context) {


    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primaryTextTheme: TextTheme(
          headline1: TextStyle(fontSize: 28,color:Colors.black87,fontWeight: FontWeight.w900),
            headline2: TextStyle(fontSize: 25,color:Colors.black87,fontWeight: FontWeight.w700),
            headline3: TextStyle(fontSize: 20,color:Colors.black87,fontWeight: FontWeight.w500),
            headline4: TextStyle(fontSize: 15,color:Colors.black87,fontWeight: FontWeight.w400),
            headline5: TextStyle(fontSize: 10,color:Colors.black87,fontWeight: FontWeight.w300),
          headline6: TextStyle(fontSize: 13,color:Colors.black87,fontWeight: FontWeight.w300),
          subtitle1: TextStyle(fontSize: 20,color:Colors.black54,fontWeight: FontWeight.w800),
          subtitle2: TextStyle(fontSize: 16,color:Colors.black54,fontWeight: FontWeight.w500),
        )
      )
    );
  }

}