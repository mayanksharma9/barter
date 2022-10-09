import 'package:barter/Helper/Auth.dart';
import 'package:barter/Screen/HomeScreen.dart';
import 'package:barter/Screen/LoginScreen.dart';
import 'package:barter/Screen/SignUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screen/Navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const MyApp({Key key, this.auth, this.firestore}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Root()),
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: Navigation()),
          ChangeNotifierProvider.value(
              value: LoginScreen(auth: auth, firestore: firestore)),
          ChangeNotifierProvider.value(
              value: HomeScreen()),
          ChangeNotifierProvider.value(value: ResgisterScreen()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: true,
            theme: ThemeData.dark(),
            home: Root()));
  }
}

class Root extends StatefulWidget with ChangeNotifier {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth(auth: _auth).user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            return LoginScreen(auth: _auth, firestore: _firestore);
          } else {
            return Navigation(auth: _auth, firestore: _firestore);
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        }
      }, //Auth stream
    );
  }
}
