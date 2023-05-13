import 'package:flutter/material.dart';

class PlaceOrderPage extends StatefulWidget{

  State<PlaceOrderPage> createState()=>PlaceOrderPageState();
}

class PlaceOrderPageState extends State<PlaceOrderPage>
{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text("Place order"),),
     body: Container(
       child: Column(
         children: [

         ],
       ),
     ),
   );
  }
}