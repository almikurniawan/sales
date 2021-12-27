import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double getDiamater(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 4;

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool isErrorLogin = false;
  String massageErrorLogin = '';

  Future<void> getToken() async {
    var apiLogin = Uri.https('kediriapp.com', '/salesapp/api/v1/auth/login');
    http.post(
      apiLogin,
      body: {
        'sales_email': username.text,
        'sales_password': password.text,
      },
    ).then((http.Response response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      if (result['status'] == 'success') {
        this.saveToken(result['api_key'], result['sales_id']);
      } else {
        setState(() {
          isErrorLogin = true;
          massageErrorLogin = result['data']['message'];
        });
      }
    }).catchError((e) {
      print(e);
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
    });
  }

  saveToken(String token, int salesId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('sales_id', salesId.toString());
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return Menu();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          child: Column(
            children: [
              Flexible(
                  flex: 3,
                  child: Container(
                    color: const Color(0xFFFF5C46),
                  )),
              Flexible(
                  flex: 2,
                  child: Container(
                    color: const Color(0xFF0C415F),
                  ))
            ],
          ),
        ),
        Positioned(
            left: -getDiamater(context) / 2,
            top: -getDiamater(context) / 2,
            child: Container(
              width: getDiamater(context),
              height: getDiamater(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: const Color(0xFF0C415F)),
            )),
        Positioned(
            right: -getDiamater(context) / 3,
            top: -getDiamater(context) / 3,
            child: Container(
              width: getDiamater(context),
              height: getDiamater(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: const Color(0xFFFF9817)),
            )),
        SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(40),
              margin: EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 60, top: 35),
                    child: Image(
                        alignment: Alignment.center,
                        height: getDiamater(context),
                        image: AssetImage('assets/images/Logo.png')),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Username",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  TextFormField(
                    controller: username,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Username",
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Password",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    ),
                  ),
                  (isErrorLogin)
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                            this.massageErrorLogin,
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          )),
                      )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF43DF3F)),
                      onPressed: () {
                        this.getToken();
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ]),
    );
  }
}
