import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_crud/services/api.dart';
import 'package:http/http.dart' as http;

class UserServices {
  getAllUser() async {
    try {
      var request = http.Request('GET', Uri.parse("$APP_URL/api/user"));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var responseString = await response.stream.bytesToString();
        final decodedMap = json.decode(responseString);
        return decodedMap;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("get data error: $e");
    }
  }
  DeleteUser() async {
      var request = http.Request('DELETE', Uri.parse("$APP_URL/api/user"));
      http.StreamedResponse response = await request.send();
      
  }
}
