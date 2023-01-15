import 'dart:convert';

//import 'package:project1/api/globals.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<http.Response> register(String name, String lastname,
      String email, String password, bool isBlind) async {
    Map data = {
      "id": 10,
      "name": name,
      "lastname": lastname,
      "email": email,
      "password": password,
      "photo": "photo",
      "isBlind": isBlind
    };
    var body = json.encode(data);
    var url = Uri.parse('https://localhost:7253/api/User/Create');
    http.Response response = await http.post(url);
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "username": email,
      "password": password,
    };
    var body = new Map<String, dynamic>();
    body['username'] = email;
    body['password'] = password;
    var url = Uri.parse('http://10.0.2.2:8000/login/');
    http.Response response = await http.post(
      url,
      body: body,
    );
    print(response.body);
    return response;
  }
}
