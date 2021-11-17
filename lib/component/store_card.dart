import 'package:flutter/material.dart';
class StoreCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  const StoreCard({ Key? key, required this.image, required this.name, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 100,
          child: Image(image: NetworkImage(this.image)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("#"+this.id.toString(),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 5,
                ),
                Text(this.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}