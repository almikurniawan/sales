import 'package:flutter/material.dart';
import 'package:sales/component/custom_appbar.dart';
import 'package:sales/component/header_menu.dart';
import 'package:sales/component/pos_card.dart';

import 'notif.dart';

class PosPage extends StatefulWidget {
  const PosPage({ Key? key }) : super(key: key);

  @override
  _PosPageState createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  List<Map<String, dynamic>> itemPos = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemPos.add({
      "id" : "#1224",
      "harga" : 10000,
      "jumlah" : 5
    });
    itemPos.add({
      "id" : "#1225",
      "harga" : 12000,
      "jumlah" : 10
    });
    itemPos.add({
      "id" : "#1226",
      "harga" : 15000,
      "jumlah" : 3
    });
    itemPos.add({
      "id" : "#1226",
      "harga" : 15000,
      "jumlah" : 3
    });
    itemPos.add({
      "id" : "#1226",
      "harga" : 15000,
      "jumlah" : 3
    });
    itemPos.add({
      "id" : "#1226",
      "harga" : 15000,
      "jumlah" : 3
    });
    itemPos.add({
      "id" : "#1226",
      "harga" : 15000,
      "jumlah" : 3
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      body: Column(
        children: [
          CustomAppBar(
            onNotificationClick: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Notif()));
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                HeaderMenu(
                  title: 'POS',
                  onBack: (){
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal : 15),
                  decoration : BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 400,
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          removeBottom: true,
                          context: context,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: itemPos.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: PosCard(item: itemPos[index], 
                                  onRemove: (){
                                    itemPos.removeAt(index);
                                    setState(() {
                                    });
                                  }, 
                                  onMin: (){
                                    itemPos[index]['jumlah']--;
                                    setState(() {
                                    });
                                  },
                                  onPlus: (){
                                    itemPos[index]['jumlah']++;
                                    setState(() {
                                    });
                                  },
                                )
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Total Payment : Rp. 340.000", style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        height: 15
                      ),
                      ElevatedButton(
                        onPressed: (){

                        }, 
                        child: Text("Confirm"),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF0C415F)
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}