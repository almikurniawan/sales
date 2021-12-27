import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PosRepository {
  Future<List<Map<String, dynamic>>> loadProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi =
        Uri.https("kediriapp.com", '/salesapp/api/v1/product/pos');
    var result = await http.get(urlApi, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    });
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    List<Map<String, dynamic>> res= new List<Map<String, dynamic>>.from(jsonObject['data']);
    return res;
  }

  Future<Map<String, dynamic>> insertPos(productId, qty, storeId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi =
        Uri.https("kediriapp.com", '/salesapp/api/v1/pos');
    var result = await http.post(urlApi, body: {
      "product_id" : productId.toString(),
      "qty" : qty.toString(),
      "store_id" : prefs.getInt('store_id').toString()
    }, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    });
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    return jsonObject;
  }
}