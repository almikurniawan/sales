import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ResumePage extends StatefulWidget {
  final Map<String, dynamic> data;
  const ResumePage({Key? key, required this.data}) : super(key: key);

  @override
  _ResumePageState createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  BluetoothDevice? selectedBluetooth;
  List<BluetoothDevice> _devices = [];
  late BluetoothDevice _device;
  bool _connected = false;
  List<dynamic>? data;
  dynamic? header;

  @override
  void initState() {
    initPlatformState();
    getData();
    super.initState();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi = Uri.https("kediriapp.com",
        '/salesapp/api/v1/pos/detail/' + widget.data['id'].toString());
    var result = await http.get(urlApi,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    setState(() {
      data = jsonObject['data'];
      header = jsonObject['header'];
    });
  }

  void _konek() {
    bluetooth.connect(selectedBluetooth!).then((value) {
      print(value);
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

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
    if (data != null) {
      NumberFormat format =
          NumberFormat.currency(locale: "id_ID", symbol: "Rp. ");

      bluetooth.isConnected.then((isConnected) {
        if (isConnected == true) {
          // bluetooth.printNewLine();
          bluetooth.printCustom("Struk Penjualan", 2, 1);
          bluetooth.printCustom(header['distributor_name'], 1, 0);
          bluetooth.printCustom("Email : "+header['distributor_email'], 1, 0);
          bluetooth.printCustom("Telp. : "+header['distributor_phone'], 1, 0);
          // bluetooth.printNewLine();
          bluetooth.print3Column("Product", "Qty", "Total", 1);
          // bluetooth.printNewLine();
          data!.forEach((element) {
            bluetooth.print3Column(
                element['product_name'],
                element['jumlah'].toString(),
                format.format(int.parse(element['total'])),
                0);
            // bluetooth.printNewLine();
          });
          bluetooth.printCustom("Terima kasih.", 0, 0);
          bluetooth.paperCut();
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Tidak ada internet.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(header ?? "");
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Penjualan"),
        backgroundColor: Color(0xFFFF5C46),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text("Product", style: TextStyle(fontWeight: FontWeight.bold), )),
                  Expanded(
                       child: Text("Qty", style: TextStyle(fontWeight: FontWeight.bold), )),
                  Text("Total", style: TextStyle(fontWeight: FontWeight.bold), )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              (data != null)
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data!.length,
                      itemBuilder: (context, idx) {
                        return Row(
                          children: [
                            Expanded(child: Text(data![idx]['product_name'])),
                            Expanded(
                                child: Text(data![idx]['jumlah'].toString())),
                            Text(data![idx]['total'].toString())
                          ],
                        );
                      },
                    )
                  : Container(),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<BluetoothDevice>(
                      value: selectedBluetooth,
                      icon: const Icon(Icons.bluetooth),
                      isExpanded: true,
                      hint: Text(
                        "Pilih Bluetooth",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onChanged: (BluetoothDevice? newValue) {
                        setState(() {
                          selectedBluetooth = newValue;
                        });
                      },
                      items: _devices.map<DropdownMenuItem<BluetoothDevice>>(
                          (BluetoothDevice value) {
                        return DropdownMenuItem<BluetoothDevice>(
                          value: value,
                          child: Text(value.name.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await initPlatformState();
                    },
                    child: Text("Refresh"),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _konek();
                    },
                    child: Text("Konek"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  await cetak();
                  // await getData();
                },
                child: Text("Print"),
                style: ElevatedButton.styleFrom(primary: Color(0xFF0C415F)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
