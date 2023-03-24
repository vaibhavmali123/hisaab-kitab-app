import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget{
  
  State createState()=>AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen>{
  @override
  Widget build(BuildContext context)
  {
  return Scaffold(
    body: Center(
      child: Text("Create category in development"),
    ),
  );
  }
}