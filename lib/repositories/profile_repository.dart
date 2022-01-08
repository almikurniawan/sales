import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sales/blocs/profile/profile_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  Future<Map<String, dynamic>> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi =
        Uri.https("kediriapp.com", '/salesapp/api/v1/auth/me');
    var result = await http.get(urlApi, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    });
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    print(jsonObject);
    return jsonObject['data'];
  }

  Future<Map<String, dynamic>> updateProfile(ProfileUpdate event) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi =
        Uri.https("kediriapp.com", '/salesapp/api/v1/auth/update');
    var result = await http.post(urlApi, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    }, body: {
      'sales_name' : event.name,
      'sales_email' : event.email,
      'sales_phone' : event.telp,
      'sales_alamat' : event.address
    });
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    print(jsonObject);
    return jsonObject['data'];
  }
}
