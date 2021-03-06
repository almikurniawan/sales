import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sales/blocs/profile/profile_bloc.dart';
import 'package:sales/blocs/profile/profile_event.dart';
import 'package:sales/blocs/profile/profile_state.dart';
import 'package:sales/component/custom_appbar.dart';
import 'package:sales/page/pos_page.dart';
import 'package:sales/page/product_page.dart';
import 'package:sales/page/qr_scan_page.dart';
import 'package:sales/page/store_list_page.dart';
import 'package:sales/page/history_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notif.dart';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  double getDiamater(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 4;

  late ProfileBloc profileBloc;
  late List dataHistory = [];

  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  late Position lokasi;

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(ProfileLoad());
    _determinePosition();

    loadHistory();
  }

  Future<void> loadHistory() async {
    // dataHistory[index]['id'],
    //                   dataHistory[index]['image'],
    //                   dataHistory[index]['name'],
    //                   dataHistory[index]['time'],
    //                   dataHistory[index]['date'],
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi = Uri.https("kediriapp.com", '/salesapp/api/v1/history/list');
    var result = await http.get(urlApi,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
    Map<String, dynamic> jsonObject = jsonDecode(result.body);
    setState(() {
      dataHistory = jsonObject['data'];
    });
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    profileBloc.close();
  }

  String? _scanBarcode;
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    await scanInsert(barcodeScanRes);
  }

  Future<void> scanInsert(String barcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('token') ?? "";
    Uri urlApi = Uri.https("kediriapp.com", '/salesapp/api/v1/scan/insert');
    var result = await http.post(urlApi, headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    }, body: {
      "qrcode": barcode,
      "latitude": lokasi.latitude.toString(),
      "longitude": lokasi.longitude.toString()
    });

    var resJson = jsonDecode(result.body);
    print(resJson);
    await prefs.setInt('store_id', resJson['data']['sales_hist_store_id']);
    await prefs.setString('store_name', resJson['data']['store_name']);
  }

  @override
  Widget build(BuildContext context) {
    print(dataHistory.length);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: TabBarView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: const Color(0xFFFF5C46),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          onNotificationClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Notif()));
                          },
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Today's Income ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Rp 2.000.000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: FittedBox(
                                      child: Text("CRT"),
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      "Average Income",
                                      style: TextStyle(
                                          color: Color(0xFFC4C4C4),
                                          fontSize: 12),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text("Rp 18.440.000",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_horiz),
                                    onPressed: () => {},
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.only(top: 10, bottom: 20),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: FittedBox(
                                      child: Text("CRT"),
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      "Average Income",
                                      style: TextStyle(
                                          color: Color(0xFFC4C4C4),
                                          fontSize: 12),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text("Rp 18.440.000",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_horiz),
                                    onPressed: () => {},
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Message Unread (21)",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Order #4421 Has Been Sent To the buyer",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "31 Minutes Ago",
                                        style: TextStyle(
                                            color: Color(0xFFC4C4C4),
                                            fontSize: 10),
                                      ),
                                    ),
                                    trailing: Icon(Icons.more_horiz),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      color: Color(0xFFF8FCFF),
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 40, right: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Statistics",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "More",
                                  style: TextStyle(
                                      color: Color(0xFFC4C4C4), fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Orders",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.trending_up,
                                              color: Color(0xFF059DF1),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "44,216",
                                          style: TextStyle(
                                              color: Color(0xFF059DF1),
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Return",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.trending_down,
                                              color: Color(0xFFFD0000),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "23,124",
                                          style: TextStyle(
                                              color: Color(0xFFFD0000),
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  CustomAppBar(
                    onNotificationClick: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Notif()));
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Menu My Sales",
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProductPage();
                                  }));
                                },
                                child: BuildCard(
                                    Icons.check_box_outline_blank, "Product"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PosPage();
                                    }));
                                  },
                                  child: BuildCard(Icons.edit_outlined, "POS")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return StoreListPage();
                                    }));
                                  },
                                  child: BuildCard(
                                      Icons.shopping_bag_outlined, "Store")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: GestureDetector(
                                  onTap: () {
                                    // scanBarcodeNormal();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const QrScanPage(),
                                    ));
                                  },
                                  child: BuildCard(
                                      Icons.qr_code_2_outlined, "Scan")),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TabHistory(context),
              // Container(
              //   width: double.infinity,
              //   child: Text("tes"),
              // ),
              Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            color: const Color(0xFFFF5C46),
                            width: double.infinity,
                            height: 300,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      alignment: Alignment.center,
                                      height: getDiamater(context),
                                      image:
                                          AssetImage('assets/images/pic.png')),
                                  Text(
                                    "Profile Account",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                if (state is ProfileUninitialized) {
                                  return CircularProgressIndicator();
                                } else if (state is ProfileLoading) {
                                  return CircularProgressIndicator();
                                } else if (state is ProfileLoaded) {
                                  namaController.text = state.salesName;
                                  emailController.text = state.salesEmail;
                                  telpController.text = state.salesPhone;
                                  alamatController.text = state.salesCode;
                                  return Container(
                                    margin: EdgeInsets.all(20),
                                    color: const Color(0xFFF9FAFA),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Nama",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: namaController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "Nama",
                                            fillColor: Colors.white,
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 16),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Email",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            fillColor: Colors.white,
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 16),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("No. Telp",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: telpController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "No. Telp",
                                            fillColor: Colors.white,
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 16),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Alamat",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: alamatController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "Alamat",
                                            fillColor: Colors.white,
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                        color:
                                                            Color(0xFF0C415F)),
                                                  ),
                                                  onPressed: () {},
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xFF0C415F)),
                                                      ),
                                                    ),
                                                  )),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Color(
                                                                0xFF0C415F))),
                                                onPressed: () {
                                                  profileBloc
                                                      .add(ProfileLoad());
                                                },
                                                child: Container(
                                                  child: Center(
                                                    child: Text('Save',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ),
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
                            shape: BoxShape.circle,
                            color: const Color(0xFF0C415F)),
                      )),
                  Positioned(
                      right: -getDiamater(context) / 3,
                      top: -getDiamater(context) / 3,
                      child: Container(
                        width: getDiamater(context),
                        height: getDiamater(context),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFF9817)),
                      )),
                ],
              )
            ],
          ),
          bottomNavigationBar: BuildMenu()),
    );
  }

  Widget TabHistory(BuildContext context) {
    // return Text("tes");
    return Column(
      children: [
        CustomAppBar(
          onNotificationClick: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Notif()));
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
                color: Color(0xFFF8FCFF),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "History Scan",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 40,
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataHistory.length,
                      itemBuilder: (context, index) => ListHistory(
                        context,
                        dataHistory[index]['id'].toString(),
                        dataHistory[index]['image'],
                        dataHistory[index]['store_name'],
                        dataHistory[index]['time'],
                        dataHistory[index]['date'],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }

  GestureDetector ListHistory(BuildContext context, String id, String url,
      String title, String jam, String tgl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HistoryDetail(id: id);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: MediaQuery.of(context).size.width * 0.2,
                  image: NetworkImage(url),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Color(0xFFFD0000), fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(jam,
                    style: TextStyle(color: Color(0xFFF43DF3F), fontSize: 12)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.forward),
                SizedBox(
                  height: 20,
                ),
                Text(
                  tgl,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container BuildMenu() {
    return Container(
      height: 74,
      // color: Colors.white,
      child: TabBar(
        labelColor: const Color(0xFFFF5C46),
        unselectedLabelColor: Color(0xFF0C415F),
        indicator: BoxDecoration(
            border: Border(top: BorderSide(color: const Color(0xFFFF5C46)))),
        indicatorPadding: EdgeInsets.all(1),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: const Color(0xFFFF5C46),
        tabs: [
          Tab(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
              // color: Color(0xFF0C415F),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.apps,
              size: 30,
              // color: Color(0xFF0C415F),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.history_toggle_off,
              size: 30,

              // color: Color(0xFF0C415F),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.person_outline,
              size: 30,

              // color: Color(0xFF0C415F),
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildCard(IconData icon, String text) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: const Color(0xFFFF5C46),
      child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Icon(
                    icon,
                    size: 50,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                child: Text(
                  text,
                  style:
                      TextStyle(color: const Color(0xFFFFFFFF), fontSize: 22),
                ),
              )),
            ],
          )),
    );
  }
}
