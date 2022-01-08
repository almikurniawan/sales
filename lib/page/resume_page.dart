import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';

class ResumePage extends StatefulWidget {
  final Map<String, dynamic> data;
  const ResumePage({Key? key, required this.data}) : super(key: key);

  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  late BluetoothDevice _device;
  bool _connected = false;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    for (int i = 0; i < devices.length; i++) {
      print(devices[i].name.toString() + " " + i.toString());
      if (devices[i].name == "RPP02N") {
        bluetooth.connect(devices[i]).catchError((error) {
          print(error);
        });
      }
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });
  }

  Future<void> cetak() async {
    print("Tes");
    bluetooth.isConnected.then((isConnected) {
      print(isConnected);
      if (isConnected == true) {
        bluetooth.printNewLine();
        bluetooth.printCustom("HEADER", 3, 1);
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await cetak();
              },
              child: Text("Print"),
              style: ElevatedButton.styleFrom(primary: Color(0xFF0C415F)),
            ),
            ElevatedButton(
              onPressed: () async {
                await initPlatformState();
              },
              child: Text("KOnek"),
              style: ElevatedButton.styleFrom(primary: Color(0xFF0C415F)),
            ),
          ],
        ),
      ),
    );
  }
}
