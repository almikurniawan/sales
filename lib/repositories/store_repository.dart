import 'package:sales/blocs/store/store_event.dart';
import 'package:sales/models/store_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class StoreRepository {
  Future<List<StoreModel>> loadStore() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi =
        Uri.https("psdjeram.kediriapp.com", '/api/v1/store/list');
    var result = await http.get(urlApi, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    });
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    List<StoreModel> listStore = jsonObject['data'].map<StoreModel>((item){
      return StoreModel(id: item['id'], name: item['name'], image: item['image']);
    }).toList();

    return listStore;
  }

  Future<void> insert(StoreInsert data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi =
        Uri.https("psdjeram.kediriapp.com", '/api/v1/store/insert');
    var result = await http.post(urlApi, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    }, body: {
      "name" : data.name,
      "owner" : data.owner,
      "phone" : data.phone,
      "address" : data.address,
      "latitude" : data.latitude,
      "longitude" : data.longitude
    });
  }

  Future<void> update(StoreUpdate data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi =
        Uri.https("psdjeram.kediriapp.com", '/api/v1/store/update');
    var result = await http.post(urlApi, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    }, body: {
      "name" : data.name,
      "owner" : data.owner,
      "phone" : data.phone,
      "address" : data.address,
      "latitude" : data.latitude,
      "longitude" : data.longitude,
      "id" : data.id.toString()
    });
  }
}