import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationService {
  //final String _url = 'http://1.0.2.2:8000/api/';
  final String _url = 'http://127.0.0.1:8000/api/';

  Future<List<dynamic>> getUnansweredData() async {
    var fullUrl = "https://1.0.2.2:8000/api/Notification/GetUnanswred";
    var result = await http.get(Uri.parse(fullUrl));
    return json.decode(result.body);
  }

  // Future<String> getUserName(int id) async {
  //   var fullUrl = "";
  //   var result = await http.get(Uri.parse(fullUrl));
  //   return json.decode(result.body);
  // }
}
