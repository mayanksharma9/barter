import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AddScreen.dart';
import 'HomeScreen.dart';
import 'ProfileScreen.dart';

class Navigation extends StatefulWidget with ChangeNotifier {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Navigation({Key key, this.auth, this.firestore}) : super(key: key);
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;
  var pages = [
    HomeScreen(),
    AddScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (i){
          setState(() {
            currentPage =i;
          });

        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text("")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("")
          ),
        ],

      ),
      body: pages[currentPage],

    );
  }
}
