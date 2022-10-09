import 'package:barter/Helper/Auth.dart';
import 'package:barter/Helper/DatabaseService.dart';
import 'package:barter/Helper/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'HomeScreen.dart';
import 'Navigation.dart';
//
// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//
//   Widget _buildName() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Full Name',
//           // style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           //decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             keyboardType: TextInputType.text,
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.person,
//                 color: Colors.black,
//               ),
//               hintText: 'Enter your Full Name',
//               //  hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildEmail() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Email',
//           // style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           //decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             keyboardType: TextInputType.emailAddress,
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.email,
//                 color: Colors.black,
//               ),
//               hintText: 'Enter your Email',
//               //  hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPassword() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Password',
//           // style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           // decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             obscureText: true,
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.black,
//               ),
//               hintText: 'Enter your Password',
//               //   hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   Widget _buildSignUpBtn() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: RaisedButton(
//         onPressed: (){
//           Navigator.push(context,MaterialPageRoute(builder: (context)=>Navigation()),);
//         },
//         elevation: 5.0,
//         padding: EdgeInsets.all(15.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         color: Colors.white,
//         child: Text(
//           'SignUp',
//           style: TextStyle(
//             color: Color(0xFF527DAA),
//             letterSpacing: 1.5,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'OpenSans',
//           ),
//         ),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: AnnotatedRegion<SystemUiOverlayStyle>(
//           value: SystemUiOverlayStyle.dark,
//           child: GestureDetector(
//             onTap: () =>FocusScope.of(context).unfocus(),
//             child: Stack(
//                 children: <Widget>[
//                   Container(
//                       height: double.infinity,
//                       child: SingleChildScrollView(
//                           physics: AlwaysScrollableScrollPhysics(),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 40.0,
//                             vertical: 120.0,
//                           ),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Text(
//                                   'SignUp',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontFamily: 'OpenSans',
//                                     fontSize: 30.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 20.0),
//                                 _buildName(),
//                                 SizedBox(height: 20.0),
//                                 _buildEmail(),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 _buildPassword(),
//                                 _buildSignUpBtn(),
//                               ]
//                           )
//                       )
//                   ),
//                 ]
//             ),
//           ),
//
//         )
//     );
//   }
// }
class ResgisterScreen extends StatefulWidget with ChangeNotifier {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ResgisterScreen({Key key, @required this.auth, @required this.firestore})
      : super(key: key);
  @override
  _ResgisterScreen createState() => _ResgisterScreen();
}

class _ResgisterScreen extends State<ResgisterScreen> {
  User currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool userExists = true;
  bool _btnEnabled = false;
  bool _autoValidate = false;
  // String Name;
  // String Username;
  // String Email;
  String _email;
  String _password;
  String username;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  //String uid=FirebaseAuth.instance.currentUser.uid;

  Future validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  // Future<bool> UsernameExists(String Username) async {
  //   final QuerySnapshot result = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .where('Username', isEqualTo: Username)
  //       .get();

  //   final List<QueryDocumentSnapshot> documents = result.docs;

  //   if (documents.length > 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  Future<UserData> AddtoDatabase(
      String Username,
      ) {
    UserData(UserName: Username);
  }

  Future userExist(String username) async {
    username = _userNameController.text.trim();
    FirebaseFirestore.instance
        .collection("Users")
        .where("Username", isNotEqualTo: username);
    setState(() {
      userExists = false;
      _btnEnabled = true;
    });
  }

  Future<void> SignUp() async {
    _formKey.currentState.validate();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.grey,
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: new Form(
                        key: _formKey,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: new InputDecoration(
                                labelText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              // hintText: "Email",
                              //textInputType: TextInputType.emailAddress,
                              obscureText: false,
                              controller: _emailController,
                              //actionKeyboard: TextInputAction.next,
                              maxLines: 1,
                              //prefixIcon: Icon(Icons.email),
                              validator: (val) =>
                              val.isEmpty ? "Email can't be empty." : null,
                              onSaved: (val) => _email = val,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            new TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: new InputDecoration(
                                labelText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              //hintText: "Password",
                              //textInputType: TextInputType.visiblePassword,
                              obscureText: true,
                              controller: _passwordController,
                              //actionKeyboard: TextInputAction.next,
                              maxLines: 1,
                              validator: (String arg) {
                                if (arg.length < 6) {
                                  return 'Password must be at least 6 character';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            new TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              decoration: new InputDecoration(
                                labelText: 'Name',
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              // hintText: "Email",
                              //textInputType: TextInputType.emailAddress,
                              obscureText: false,
                              controller: _nameController,
                              //actionKeyboard: TextInputAction.next,
                              maxLines: 1,
                              //prefixIcon: Icon(Icons.email),
                              validator: (val) =>
                              val.isEmpty ? "Name can't be empty." : null,
                              onSaved: (val) => _email = val,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            new TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              decoration: new InputDecoration(
                                labelText: 'Username',
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              // hintText: "Email",
                              //textInputType: TextInputType.emailAddress,
                              obscureText: false,
                              controller: _userNameController,
                              //actionKeyboard: TextInputAction.next,
                              maxLines: 1,
                              //prefixIcon: Icon(Icons.email),
                              validator: (val) => val.isEmpty
                                  ? "Username can't be empty."
                                  : null,
                              onSaved: (val) => username = val,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {
                            _formKey.currentState.validate();
                            //userExists(_userNameController.text);
                            final String retval =
                            await Auth(auth: widget.auth).createAccount(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (retval == "Success") {
                              await DatabaseService(
                                  uid:
                                  FirebaseAuth.instance.currentUser.uid)
                                  .createUser(userData: UserData(Email: _emailController.text , Name:_nameController.text , UserName: _userNameController.text , PhoneNumber: '' ,
                                  ID: FirebaseAuth.instance.currentUser.uid , ProfilePicture: '' , Posts: 0 ,  CreationDate: Timestamp.now()));
                              _emailController.clear();
                              _passwordController.clear();
                              _nameController.clear();
                              _userNameController.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Navigation()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(retval),
                                ),
                              );
                            }
                          },
                          color: Colors.greenAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

