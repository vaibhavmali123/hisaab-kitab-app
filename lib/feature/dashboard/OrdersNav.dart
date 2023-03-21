import 'package:flutter/material.dart';

class OrdersNav extends StatefulWidget{

  State<OrdersNav>createState()=>OrdersNavState();
}

class OrdersNavState extends State<OrdersNav>
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(child: Text('orders'),),
    );

    throw UnimplementedError();
  }
}