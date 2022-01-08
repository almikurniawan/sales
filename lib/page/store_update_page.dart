import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales/blocs/store/store_bloc.dart';
import 'package:sales/blocs/store/store_event.dart';
import 'package:sales/blocs/store/store_state.dart';
import 'package:sales/component/custom_appbar.dart';
import 'package:sales/component/header_menu.dart';
import 'package:geolocator/geolocator.dart';
import 'notif.dart';

class StoreUpdatePage extends StatefulWidget {
  final int id;
  final String name;
  final String owner;
  final String phone;
  final String address;
  const StoreUpdatePage({Key? key, required this.phone, required this.owner, required this.name, required this.address, required this.id}) : super(key: key);

  @override
  _StoreUpdatePageState createState() => _StoreUpdatePageState();
}

class _StoreUpdatePageState extends State<StoreUpdatePage> {
  TextEditingController name = TextEditingController();
  TextEditingController owner = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  late Position lokasi;
  late StoreBloc storeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
    name.text = widget.name;
    owner.text = widget.owner;
    phone.text = widget.phone;
    address.text = widget.address;
    storeBloc = BlocProvider.of<StoreBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
      listener: (ctx, state) {
        if (state is StoreSuccessInsert) {
          Fluttertoast.showToast(
              msg: "Berhasil Update Store.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF8FCFF),
        body: Column(
          children: [
            CustomAppBar(
              onNotificationClick: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Notif()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderMenu(
                        title: 'Store',
                        onBack: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Nama Toko"),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text("Pemilik Toko"),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: owner,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text("No. Telp"),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: phone,
                        decoration: InputDecoration(
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
                      SizedBox(
                        height: 10,
                      ),
                      Text("Alamat"),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: address,
                        decoration: InputDecoration(
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
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            storeBloc.add(StoreUpdate(
                              address: address.text,
                              latitude: lokasi.latitude.toString(),
                              longitude: lokasi.longitude.toString(),
                              name: name.text,
                              owner: owner.text,
                              phone: phone.text, 
                              id: widget.id
                            ));
                          },
                          child: Text("Save"),
                          style: ElevatedButton.styleFrom(primary: Color(0xFF0C415F)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
