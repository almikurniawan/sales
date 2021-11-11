import 'dart:convert';

import 'package:http/http.dart' as http;

class ProfileRepository {
  Future<Map<String, dynamic>> loadProfile() async{
    Uri urlApi = Uri.https("https://psdjeram.kediriapp.com/", '/api/v1/auth/me');
    var result = await http.get(urlApi);
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    return jsonObject;
  }
}