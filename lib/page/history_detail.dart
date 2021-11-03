import 'package:flutter/material.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({Key? key}) : super(key: key);

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                Text(
                  "Detail",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
            CircleAvatar(
              child: FittedBox(
                child: Text("CRT"),
              ),
            ),
            Text("Toko Suryana",style: TextStyle(color: Color(0xFFFD0000),fontSize: 24),),
            
          ],
        ),
      ),
    );
  }
}
