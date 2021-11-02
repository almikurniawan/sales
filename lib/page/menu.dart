import 'package:flutter/material.dart';
import 'package:sales/component/custom_appbar.dart';
import 'package:sales/page/pos_page.dart';
import 'package:sales/page/product_page.dart';
import 'package:sales/page/store_list_page.dart';
import 'notif.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  double getDiamater(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 4;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: TabBarView(
            children: [
              Column(
                children: [
                  CustomAppBar(
                    onNotificationClick: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Notif()));
                    },
                  ),
                  Container(child: Icon(Icons.home_outlined)),
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
                  SingleChildScrollView(
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
                            child: BuildCard(Icons.qr_code_2_outlined, "Scan"),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  Container(child: Icon(Icons.history_toggle_off)),
                ],
              ),
              Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: const Color(0xFFFF5C46),
                            width: double.infinity,
                            height: 238,
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
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.all(20),
                              color: const Color(0xFFF9FAFA),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Nama",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  TextFormField(
                                    // controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Nama",
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
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 16),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Email",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  TextFormField(
                                    // controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Email",
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
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 16),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("No. Telp",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  TextFormField(
                                    // controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "No. Telp",
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
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 16),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Alamat",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  TextFormField(
                                    // controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Alamat",
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
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  color: Color(0xFF0C415F)),
                                            ),
                                            onPressed: () {},
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF0C415F)),
                                                ),
                                              ),
                                            )),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xFF0C415F))),
                                          onPressed: () {},
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
