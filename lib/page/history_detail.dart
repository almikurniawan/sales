// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({Key? key}) : super(key: key);

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF8FCFF),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "Detail",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Container(
        color: Color(0xFFF8FCFF),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              width: MediaQuery.of(context).size.width * 0.2,
              image: NetworkImage("url"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Toko Suryana",
              style: TextStyle(color: Color(0xFFFD0000), fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(3),
              },
              children: [
                TableRow(children: [
                  TableCell(child: Text("Tanggal")),
                  TableCell(child: Text(": 09-18-2021")),
                ]),
                TableRow(children: [
                  TableCell(child: Text("Waktu")),
                  TableCell(child: Text(": 07.00 WIB")),
                ]),
                TableRow(children: [
                  TableCell(child: Text("Keterangan")),
                  TableCell(
                      child: Text(
                    ": Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quam viverra id purus posuere. Nisi amet, risus, risus amet potenti adipiscing dolor nunc nec. Bibendum pellentesque ipsum diam quis. Amet, aenean placerat turpis facilisi. Velit, sapien integer praesent commodo interdum dui eu nullam adipiscing. ",
                    textAlign: TextAlign.justify,
                  )),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
