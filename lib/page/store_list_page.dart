import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/blocs/store/store_bloc.dart';
import 'package:sales/blocs/store/store_event.dart';
import 'package:sales/blocs/store/store_state.dart';
import 'package:sales/component/custom_appbar.dart';
import 'package:sales/component/header_menu.dart';
import 'package:sales/component/store_card.dart';
import 'package:sales/page/store_page.dart';

import 'notif.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({Key? key}) : super(key: key);

  @override
  _StoreListPageState createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  late StoreBloc storeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeBloc = BlocProvider.of<StoreBloc>(context);
    storeBloc.add(StoreLoad());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    storeBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return StorePage();
          }));
        },
        child: Icon(Icons.add),
        style: ElevatedButton.styleFrom(primary: Color(0xFFFF5C46)),
      ),
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
                    BlocBuilder<StoreBloc, StoreState>(
                      builder: (context, state) {
                        if (state is StoreUninitialized) {
                          return CircularProgressIndicator();
                        } else if (state is StoreLoaded) {
                          return MediaQuery.removePadding(
                            removeTop: true,
                            removeBottom: true,
                            context: context,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.items.length,
                                itemBuilder: (_, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                  context, MaterialPageRoute(builder: (context) => StorePage()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: StoreCard(id : state.items[index].id,
                                      name : state.items[index].name,
                                      image : state.items[index].image)
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
