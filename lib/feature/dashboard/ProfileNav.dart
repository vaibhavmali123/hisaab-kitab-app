import 'package:flutter/material.dart';

class ProfileNav extends StatefulWidget{

  State<ProfileNav> createState()=>ProfileNavState();
}

class ProfileNavState extends State<ProfileNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('profile'),),
    );
    throw UnimplementedError();
  }
}