// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final int id;
  final String name;
  final String price;
  final String formatPrice;
  final String stock;
  final String formatStock;
  final String? urlImage;

  const ProductCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.formatPrice,
      required this.stock,
      required this.formatStock,
      this.urlImage,
      })
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image(
          width: MediaQuery.of(context).size.width * 0.2,
          image: NetworkImage(widget.urlImage ?? "https://www.almahmood.co/wp-content/uploads/2020/04/test-product.png"),
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
                      child: Text("#"+widget.id.toString(),
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                    Expanded(
                      child: Text(
                        "Stock : "+widget.stock,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.grey)),
                    ),
                    Expanded(
                      child: Text("Rp. "+widget.formatPrice,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.grey)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
