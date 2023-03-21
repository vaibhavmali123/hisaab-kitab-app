import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hisab_kitab/feature/authentication/LoginScreen.dart';
import 'package:flutter/services.dart';

 class SplashScreen extends StatefulWidget{

  State<SplashScreen> createState(){
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white, // status bar color
    ));
    startTimer(context);

   }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/pos_system.png",height: 180,width: 180,),
          ],
        ),
      ),
    );
  }
}

void startTimer(BuildContext context) {
   Timer(Duration(seconds: 2), () {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
   });
}