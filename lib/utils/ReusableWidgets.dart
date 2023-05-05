import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReusableWidgets
{

 static InputBorder inputBorder=OutlineInputBorder(
   borderSide: BorderSide(color: Colors.black45,width: 1),
 ) as InputBorder;

 static InputBorder focusedInputBorder=OutlineInputBorder(
   borderSide: BorderSide(color: Colors.black87,width: 1),
 ) as InputBorder;

 static InputBorder errorInputBorder=OutlineInputBorder(
   borderSide: BorderSide(color: Colors.red,width: 1),
 ) as InputBorder;

 static InputBorder focussedErrorInputBorder=OutlineInputBorder(
   borderSide: BorderSide(color: Colors.red,width: 1),
 ) as InputBorder;

 static Widget loader=Center(child: CircularProgressIndicator());

 static BoxDecoration dropDownBorder=BoxDecoration(
   borderRadius: BorderRadius.circular(20),
  border: Border.all(width: 1,color: Colors.black87)
 );

 static showToast({required String msg,required bool type}){
   Fluttertoast.showToast(msg: msg,textColor:Colors.white ,
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.CENTER,
     backgroundColor:type==true?Colors.green:Colors.red,fontSize: 18, );
 }

}