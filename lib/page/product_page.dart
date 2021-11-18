// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sales/component/custom_appbar.dart';
import 'package:sales/component/header_menu.dart';
import 'package:sales/component/product_card.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'notif.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late List data = [];
  @override
  void initState() {
    super.initState();
    getProduct();
  }
  Future<void> getProduct() async {
    var apiPoduct =
        Uri.https('psdjeram.kediriapp.com', '/api/v1/product/list', {
          'query' : 'Bidara'
        });
    String token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token'))!;
    http.get(apiPoduct, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    }).then((http.Response response) {
      dynamic ambil = json.decode(response.body);
      setState(() {
        data = ambil['data'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: Column(
        children: [
          CustomAppBar(
            onNotificationClick: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Notif()));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    HeaderMenu(
                      title: 'Product',
                      onBack: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                        decoration: InputDecoration(
                      hintText: "Search Product",
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    MediaQuery.removePadding(
                      removeTop: true,
                      removeBottom: true,
                      context: context,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: 
                              ProductCard(
                                id: data[index]['id'],
                                name: data[index]['name'],
                                price: data[index]['price'],
                                formatPrice: data[index]['format_price'] ?? "",
                                stock: data[index]['stock'],
                                formatStock: data[index]['format_stock'],
                                urlImage: data[index]['image'],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
