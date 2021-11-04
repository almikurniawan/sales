import 'package:flutter/material.dart';

import 'login.dart';
import 'menu.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
          width: double.infinity,
          // color: Colors.red,
          child: Column(
            children: [
              Flexible(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    color: Color(0xFFFF5C46),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "My Sales",
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Text(
                            "For your easier job, manage and reminding",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )),
              Flexible(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    color: Color(0xFF0C415F),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                          },
                          child: Text(
                            "Get Started",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)))),
                        ),
                      ),
                    ),
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
      ]),
    );
  }
}