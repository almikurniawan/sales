// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryDetail extends StatefulWidget {
  final String id;
  const HistoryDetail({Key? key, required this.id}) : super(key: key);

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {

  dynamic data;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetail();
  }

  Future<void> getDetail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi =
        Uri.https("kediriapp.com", '/salesapp/api/v1/history/show/'+widget.id);
    var result = await http.get(urlApi, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    });
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    setState(() {
      data = jsonObject['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(data);
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
      body: 
      (data==null) ? Center(child: CircularProgressIndicator(),) : 
      Container(
        color: Color(0xFFF8FCFF),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              width: MediaQuery.of(context).size.width * 0.2,
              image: NetworkImage(data['image']),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              data['store_name'],
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
                  TableCell(child: Text(": "+data['date'])),
                ]),
                TableRow(children: [
                  TableCell(child: Text("Waktu")),
                  TableCell(child: Text(": "+data['time'])),
                ]),
                TableRow(children: [
                  TableCell(child: Text("Keterangan")),
                  TableCell(
                      child: Text(
                    ": " + (data['note'] ?? ""),
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
