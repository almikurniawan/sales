import 'package:flutter/material.dart';

import 'menu.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double getDiamater(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 4;

  String email = 'user@mail.com';
  String password = '123456';

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

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
                    padding: EdgeInsets.only(bottom: 60,top: 35),
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
                    // controller: _emailController,
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
                    // controller: _emailController,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF43DF3F)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Menu()),
                        );
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width * 0.8,
                        // height: MediaQuery.of(context).size.height * 0.06,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 13),
                  //   child: OutlinedButton(
                  //     style: OutlinedButton.styleFrom(
                  //       side: BorderSide(color: Colors.white),
                  //     ),
                  //     onPressed: () {},
                  //     child: Container(
                  //       // width: MediaQuery.of(context).size.width * 0.8,
                  //       // height: MediaQuery.of(context).size.height * 0.06,
                  //       child: Center(
                  //         child: Text(
                  //           'Sign Up',
                  //           style: TextStyle(fontSize: 16, color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )),
        ),
      ]),
    );
  }
}
