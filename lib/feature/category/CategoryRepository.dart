import 'package:dio/dio.dart';
import 'package:hisab_kitab/networking/ApiHandler.dart';
import 'package:hisab_kitab/feature/category/model/CategoriesModel.dart';

import '../../networking/ApiProvider.dart';
import '../../networking/EndPoint.dart';
import 'model/CategoriesModel.dart';
import 'model/CategoriesModel.dart';
import 'model/CategoriesModel.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
class CategoryRepository
{
  final Dio _dio = Dio();

  Future<CategoriesModel> fetchCategories() async {
    var cat=CategoriesModel.forInst();

    var client = http.Client();

    var response = await client.get(Uri.parse(ApiProvider.baseUrl+EndPoint.getAllCategories));

    Map<String, dynamic> mapResponse;

    try {
      if (response.statusCode == 200) {
        print("RESPONSE ${response.body.toString()}");

        mapResponse = json.decode(response.body);
        return CategoriesModel.fromJson(mapResponse);
      }
    } catch (e) {
      return cat;
      print("Exception caught ${e.toString()}");
    }
    return cat;

    /*
    try {
      Response response = await _dio.get(ApiProvider.baseUrl+EndPoint.getAllCategories);
      print("RESPONSE ${response.toString()}");

      return CategoriesModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return cat;*/

  }
}