import 'package:flutter/material.dart';
import 'package:hisab_kitab/networking/ApiProvider.dart';
import 'package:hisab_kitab/networking/ApiHandler.dart';
import '../../utils/ReusableWidgets.dart';
import '../../utils/StringResources.dart';
import 'package:hisab_kitab/networking/EndPoint.dart';

class LoaderNotifier extends ChangeNotifier{

  bool loading=false;
  bool isBack=false;
bool isSuccess=false;

Future<void>postData({required String baseUrl, required String endApi, required var request})async{
loading=true;
ApiHandler.postApi(baseUrl:baseUrl, endApi:endApi,request:request).then((value) {

  print("RES ${value.toString()}");
  print("Response ${value!["statusCode"]}");

  if (value!["statusCode"] == "200") {
    isBack = true;
   loading = false;
    notifyListeners();
  }
});}
}