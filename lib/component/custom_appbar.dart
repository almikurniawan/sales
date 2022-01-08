import 'package:flutter/material.dart';
import 'package:sales/page/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onNotificationClick;
  final VoidCallback? onMenuClick;
  const CustomAppBar({Key? key, this.onNotificationClick, this.onMenuClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (await prefs.containsKey('token')) {
        await prefs.remove('token');
        await prefs.remove('sales_id');

        if (await prefs.containsKey('store_id')) {
          await prefs.remove('store_id');
          await prefs.remove('store_name');
        }
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
    }

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
              onTap: () {
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
              onTap: () {
                // this.onNotificationClick!();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Konfirmasi"),
                      content: Text("Apakah anda yakin ingin keluar?"),
                      actions: [
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text("Ya"),
                          onPressed: () {
                            logout();
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Icon(
                Icons.logout,
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
