import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales/blocs/pos/pos_bloc.dart';
import 'package:sales/blocs/pos/pos_state.dart';
import 'package:sales/blocs/profile/profile_bloc.dart';
import 'package:sales/blocs/profile/profile_state.dart';
import 'package:sales/blocs/store/store_bloc.dart';
import 'package:sales/blocs/store/store_state.dart';
import 'package:sales/page/landing_page.dart';
import 'package:sales/page/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart' as http;

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();

  runApp(const MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ), iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();

  final service = FlutterBackgroundService();
  service.setForegroundMode(false);

  Timer.periodic(const Duration(seconds: 10), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();

    Position lokasi = await Geolocator.getCurrentPosition();
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi = Uri.https("kediriapp.com", '/salesapp/api/v1/sales/tracking');
    var result = await http.post(urlApi,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token},
        body: {
          "datetime" : DateTime.now().toString(),
          "latitude": lokasi.latitude.toString(),
          "longitude": lokasi.longitude.toString()
        });
  });
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