import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter_crud/services/api.dart';
import 'package:http/http.dart' as http;

class UserServices {
  getAllUser() async {
    try {
      var request = http.Request('GET', Uri.parse("$APP_URL/api/user"));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
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

  DeleteUser(String id) async {
    try {
      var deleteUser = await http.delete(
        Uri.parse('$APP_URL/api/user/$id'),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
      );
      return deleteUser.statusCode;
    } catch (e) {
      print(e);
    }
  }

  createNewUser(body) async {
    try {
      var result = await http.post(Uri.parse('$APP_URL/api/user'),
          headers: {"Content-Type": "application/json; charset=UTF-8"},
          body: jsonEncode(body));
      return result.statusCode;
    } catch (e) {
      print(e);
    }
  }

  updateUser(body, id) async {
    try {
      var updateUser = await http.put(Uri.parse("$APP_URL/api/user/$id"),
          headers: {"Content-Type": "application/json; charset=UTF-8"},
          body: jsonEncode(body));
      return updateUser.statusCode;
    } catch (e) {
      print(e);
    }
  }
}
