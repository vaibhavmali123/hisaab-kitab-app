import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiHandler{

  static Future<Map<String, dynamic>?> getApi({required String baseUrl, required String endApi}) async {
    var client = http.Client();

    var response = await client.get(Uri.parse(baseUrl + endApi));

    Map<String, dynamic> mapResponse;

    try {
      if (response.statusCode == 200) {
        print("RESPONSE ${response.body.toString()}");

        mapResponse = json.decode(response.body);
        print("RESPONSE 2 ${response.body.toString()}");

        return mapResponse;
      }
  return null;
    } catch (e) {
      print("Exception caught ${e.toString()}");
    }
  }

  static Future<Map<String, dynamic>?> postApi({required String baseUrl, required String endApi, required var request}) async {
    var client = http.Client();
    String apiUrl=baseUrl + endApi;

    var response = await client.post(Uri.parse(baseUrl + endApi) ,headers: {"Content-Type":"application/json"}, body: request);
    print("Response ${response.body.toString()}");

    Map<String, dynamic> mapResponse;
    print("Request ${request.toString()}");

    try {
      if (response.statusCode == 200) {
        mapResponse = json.decode(response.body);
        return mapResponse;
      }
    } catch (e) {
      print("Exception caught ${e.toString()}");
    }
  }
}
