import 'package:barter/Helper/Auth.dart';
import 'package:barter/Screen/SignUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//     // Create a new credential
//     final OAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//
//   Widget _buildEmailTF() {
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
//   Widget _buildPasswordTF() {
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
//
//   Widget _buildForgotPasswordBtn() {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: FlatButton(
//         onPressed: () => print('Forgot Password Button Pressed'),
//         padding: EdgeInsets.only(right: 0.0),
//         child: Text(
//           'Forgot Password?',
//         ),
//       ),
//     );
//   }
//   Widget _buildLoginBtn() {
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
//           'LOGIN',
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
//
//   Widget _signUp(){
//     return Container(
//       alignment: Alignment.center,
//       child: FlatButton(
//         onPressed: () {
//           Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()),);
//         },
//         padding: EdgeInsets.only(right: 0.0),
//         child: Text(
//           'SignUp',
//            style: TextStyle(
//              fontSize: 20
//            ) ,
//         ),
//       ),
//     );
//   }
//   Widget _or(){
//     return Container(
//       alignment: Alignment.center,
//       child: Text(
//         'Or Continue with',
//          style: TextStyle(
//            fontSize: 20
//          ),
//       ),
//     );
//   }
//
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
//                                   'Welcome to Barter',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontFamily: 'OpenSans',
//                                     fontSize: 30.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 20.0),
//                                 _buildEmailTF(),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 _buildPasswordTF(),
//                                 _buildForgotPasswordBtn(),
//                                 _buildLoginBtn(),
//                                 _signUp(),
//                                 _or(),
//                               ]
//                           )
//                       )
//                   ),
//                       Container(
//                         alignment: Alignment.bottomCenter,
//                         margin: EdgeInsets.only(
//                           bottom: 40,
//                         ),
//                         child: GoogleSignInButton(
//                           onPressed: () {
//                             signInWithGoogle();
//                           },
//                         ),
//                       )
//                 ]
//             ),
//           ),
//         )
//     );
//   }
// }

class LoginScreen extends StatefulWidget with ChangeNotifier {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  LoginScreen({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          // style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () async {
          final String retVal = await Auth(auth: widget.auth).signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          if (retVal == "Success") {
            _emailController.clear();
            _passwordController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(retVal),
              ),
            );
          }
        },
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.greenAccent,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 120.0,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Welcome to Barter',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20.0),
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
                                  prefixIcon: Icon(Icons.email_outlined),
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
                                height: 20.0,
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
                                  prefixIcon: Icon(Icons.lock_outline),
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
                                height: 20.0,
                              ),
                              _buildForgotPasswordBtn(),
                              _buildLoginBtn(),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "New to Barter?",
                                    style: TextStyle(),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResgisterScreen(),),
                                      );
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ]),
                      ))),
            ]),
          ),
        ));
  }
}
