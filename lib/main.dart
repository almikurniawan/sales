import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/blocs/pos/pos_bloc.dart';
import 'package:sales/blocs/pos/pos_state.dart';
import 'package:sales/blocs/profile/profile_bloc.dart';
import 'package:sales/blocs/profile/profile_state.dart';
import 'package:sales/blocs/store/store_bloc.dart';
import 'package:sales/blocs/store/store_state.dart';
import 'package:sales/page/landing_page.dart';
import 'package:sales/page/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<Widget> loadWidget() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (await prefs.containsKey('token')) {
        return Menu();
      } else {
        return LandingPage();
      }
    }

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            return ProfileBloc(ProfileUninitialized());
          }),
          BlocProvider(create: (BuildContext context) {
            return StoreBloc(StoreUninitialized());
          }),
          BlocProvider(create: (BuildContext context) {
            return PosBloc(PosProductUninitialized());
          }),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
              future: loadWidget(),
              builder: (BuildContext context, AsyncSnapshot<Widget> widget) {
                if (widget.hasData) {
                  if (widget.data != null) {
                    return widget.data as Widget;
                  } else {
                    return LandingPage();
                  }
                } else {
                  return LandingPage();
                }
              }),
        ));
  }
}