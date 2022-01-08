import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sales/blocs/pos/pos_bloc.dart';
import 'package:sales/blocs/pos/pos_event.dart';
import 'package:sales/blocs/pos/pos_state.dart';
import 'package:sales/component/custom_appbar.dart';
import 'package:sales/component/header_menu.dart';
import 'package:sales/component/pos_card.dart';
import 'package:sales/page/resume_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notif.dart';

class PosPage extends StatefulWidget {
  const PosPage({Key? key}) : super(key: key);

  @override
  _PosPageState createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  List<Map<String, dynamic>> itemPos = [];
  late PosBloc posBloc;
  double total = 0.0;
  String storeName = "";
  int storeId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posBloc = BlocProvider.of<PosBloc>(context);
    posBloc.add(PosLoadProduct());

    this.getStore();
  }

  Future<void> getStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storeId = await prefs.getInt('store_id') ?? 0;
    storeName = await prefs.getString('store_name') ?? "";
    setState(() {
      storeId = storeId;
      storeName = storeName;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat format =
        NumberFormat.currency(locale: "id_ID", symbol: "Rp. ");
    return BlocListener<PosBloc, PosState>(
      listener: (ctx, state) {
        if (state is PosSuccessInsert) {
          // Fluttertoast.showToast(
          //   msg: "Berhasil Membuat Order.",
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.green,
          //   textColor: Colors.white,
          //   fontSize: 16.0
          // );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
            return ResumePage(data: state.data);
          }));
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF8FCFF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                onNotificationClick: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notif()));
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    HeaderMenu(
                      title: 'POS',
                      onBack: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    (storeId > 0)
                        ? Text(
                            "Toko " + storeName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Scan Toko terlebih dahulu !.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          removeBottom: true,
                          context: context,
                          child: BlocBuilder<PosBloc, PosState>(
                            builder: (ctx, state) {
                              if (state is PosProductLoaded) {
                                double total = state.data.fold(0.0, (acc, cur) {
                                  double? price = double.tryParse(cur['price']);
                                  double? jumlah = cur['jumlah'].toDouble();
                                  double? sub_total = jumlah! * price!;
                                  return acc + sub_total;
                                });

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: state.data.length,
                                        itemBuilder: (_, index) {
                                          // return Text("tes");
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: PosCard(
                                                item: state.data[index],
                                                onRemove: () {
                                                  state.data.removeAt(index);
                                                  setState(() {});
                                                },
                                                onMin: () {
                                                  state.data[index]['jumlah']--;
                                                  setState(() {});
                                                },
                                                onPlus: () {
                                                  state.data[index]['jumlah']++;
                                                  setState(() {});
                                                },
                                              ));
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Total Payment : Rp. " +
                                          format.format(total),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 15),
                                    ElevatedButton(
                                      onPressed: () {
                                        posBloc.add(PosInsert(
                                            productId: state.data[0]['id'],
                                            qty: state.data[0]['jumlah'],
                                            storeId: storeId));
                                      },
                                      child: Text("Confirm"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF0C415F)),
                                    )
                                  ],
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
