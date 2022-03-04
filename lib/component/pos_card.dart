import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PosCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onRemove; 
  final VoidCallback? onMin;
  final VoidCallback? onPlus;
  const PosCard({Key? key, required this.item, this.onRemove, this.onMin, this.onPlus}) : super(key: key);

  @override
  _PosCardState createState() => _PosCardState();
}

class _PosCardState extends State<PosCard> {
  NumberFormat format = NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. "
  );
  
  @override
  Widget build(BuildContext context) {
    double? price = double.tryParse(widget.item['price']);

    return Container(
      padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            width: MediaQuery.of(context).size.width * 0.2,
            image: NetworkImage(
                widget.item['image'] ?? "https://www.almahmood.co/wp-content/uploads/2020/04/test-product.png"),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(widget.item['name'].toString(),
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text("Stock : "+widget.item['stock'].toString(), style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w800),)
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(child: Icon(Icons.remove), onTap: (){
                      widget.onMin!();
                    }, ),
                    Text(widget.item['jumlah'].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(child: Icon(Icons.add), onTap: (){
                      widget.onPlus!();
                    }, ),
                  ],
                ),
                Text((format.format((price ?? 0 * widget.item['jumlah'])).toString()))
              ],
            ),
          )),
          // IconButton(onPressed: (){
          //   widget.onRemove!();
          // }, icon: Icon(Icons.close, color: Colors.red,))
        ],
      ),
    );
  }
}
