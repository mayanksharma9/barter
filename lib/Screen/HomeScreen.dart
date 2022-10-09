import 'package:barter/Helper/Filter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'MainContent.dart';

class HomeScreen extends StatefulWidget with ChangeNotifier {
  // final FirebaseAuth auth;
  // final FirebaseFirestore firestore;
  //
  // HomeScreen({Key key, this.auth, this.firestore}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Maincontent(),
      appBar: AppBar(
        title: Text("Barter"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          GestureDetector(
            // onTap: () {
            //   _showBottomFilter();
            // },
            child: IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                _showBottomFilter();
              },
            ),
          )
        ],
      ),
    );
  }

  void _showBottomFilter() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Filter(),
            ],
          );
        });
  }
}
