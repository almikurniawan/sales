import 'package:flutter/material.dart';
class HeaderMenu extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  const HeaderMenu({Key? key, required this.title, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            this.onBack!();
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 40,
          ),
        ),
        Text(
          this.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 40,
        )
      ],
    );
  }
}
