import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5C46),
        leading: Builder(builder: (BuildContext context){
          return IconButton(icon:Icon(Icons.close) ,
          onPressed: (){
            Navigator.pop(context);
          },tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,);
        },),
        centerTitle: true,
        title: Text("Notification"),
      ),
      body: Container(
        // margin: EdgeInsets.all(15),
        // padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
            BuildCard(
                "Order #4421 Has Been Sent To the buyer", "30 Minutes ago"),
          ],
        ),
      ),
    );
  }

  Card BuildCard(String title, String subtitle) {
    return Card(
        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          children: [
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Icon(Icons.more_horiz),
          )
        ]));
  }
}
