import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onNotificationClick;
  final VoidCallback? onMenuClick;
  const CustomAppBar({Key? key, this.onNotificationClick, this.onMenuClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFF5C46),
      height: 108,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                this.onMenuClick!();
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 24,
              ),
            ),
            Text("My Sales",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: (){
                this.onNotificationClick!();
              },
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
