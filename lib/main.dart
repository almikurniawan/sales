import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/blocs/profile/profile_bloc.dart';
import 'package:sales/blocs/profile/profile_state.dart';
import 'package:sales/page/landing_page.dart';
import 'package:sales/page/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            return ProfileBloc(ProfileUninitialized());
          }),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LandingPage(),
        ) 
    );
  }
}

