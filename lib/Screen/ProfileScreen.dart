import 'package:barter/Helper/Auth.dart';
import 'package:barter/Screen/Image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class ProfileScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const ProfileScreen({Key key, this.auth, this.firestore}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // appBar: AppBar(
      //   title: Text("Profile"),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   actions: <Widget> [
      //     IconButton(
      //       icon: Icon(Icons.settings),
      //       onPressed: (){
      //
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.collections_bookmark),
      //       onPressed: (){
      //
      //       },
      //     )
      //
      //   ],
      // ),
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              // CircleAvatar(
              //   backgroundImage: AssetImage(""),
              // ),
              // Text(("${data['UserName']}"),
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 20.0),),
              // Positioned(
              //   right: -12,
              //   bottom: 0,
              //   child: SizedBox(
              //     height: 46,
              //     width: 46,
              //     child: FlatButton(
              //       padding: EdgeInsets.zero,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(50),
              //         side: BorderSide(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        SizedBox(height: 20),
       // Menu(icon: Icons.person_outline, text: "My Account", press: () {}),
        // Menu(
        //     icon: Icons.notifications_none_outlined,
        //     text: "Notification",
        //     press: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUpload()));
        //     }),
       //  Menu(icon: Icons.settings_outlined, text: "Settings", press: () {}),
       //  Menu(icon: Icons.help_center_outlined, text: "help", press: () {}),
        Menu(icon: Icons.login_outlined, text: "Logout", press: () async {
          await Auth(auth: widget.auth)
              .signOut()
              .whenComplete(() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(
                    auth: null,
                    firestore: null,
                  ))));
        }),
      ],
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        color: Color(0xFFFFFFF),
        onPressed: press,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
