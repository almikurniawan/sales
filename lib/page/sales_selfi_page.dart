import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesSelfiPage extends StatefulWidget {
  final String barcode;
  const SalesSelfiPage({Key? key, required this.barcode}) : super(key: key);

  @override
  _SalesSelfiPageState createState() => _SalesSelfiPageState();
}

class _SalesSelfiPageState extends State<SalesSelfiPage> {
  File? _image;
  late Position lokasi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
    openCamera();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    lokasi = await Geolocator.getCurrentPosition();
  }

  Future<void> openCamera() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);

    var file = File(pickedImage!.path);
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    
    var request = http.MultipartRequest(
        'POST', Uri.https("kediriapp.com", '/salesapp/api/v1/scan/insert'),

    );
    Map<String,String> headers={
      "Authorization":"Bearer $token",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
        http.MultipartFile(
           'file',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: "absensi",
          contentType: MediaType('image','jpeg'),
        ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "qrcode": widget.barcode,
      "latitude": lokasi.latitude.toString(),
      "longitude": lokasi.longitude.toString()
    });
    var res = await request.send();
    final respStr = await res.stream.bytesToString();

    var resJson = jsonDecode(respStr);
    print(resJson);
    await prefs.setInt('store_id', resJson['data']['sales_hist_store_id']);
    await prefs.setString('store_name', resJson['data']['store_name']);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10,),
              Text("Mohon Tunggu Beberapa menit."),
              Text("Sedang mengirim data ke server."),

            ],
          ),
        ),
      ),
    );
  }
}
