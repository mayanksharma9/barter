import 'package:barter/Screen/ChatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final DocumentSnapshot postDetail;

  const DetailsScreen({Key key, this.postDetail}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int currentIndex = 0;

  // void _next() {
  //   setState(() {
  //     if (currentIndex < products.length - 1) {
  //       currentIndex++;
  //     } else {
  //       currentIndex = currentIndex;
  //     }
  //   });
  // }

  // void _preve() {
  //   setState(() {
  //     if (currentIndex > 0) {
  //       currentIndex--;
  //     } else {
  //       currentIndex = 0;
  //     }
  //   });
  // }

  // Widget _indicator(bool isActive) {
  //   return Expanded(
  //     child: Container(
  //       height: 4,
  //       margin: EdgeInsets.only(right: 5),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(50),
  //           color: isActive ? Colors.grey[800] : Colors.white),
  //     ),
  //   );
  // }

  // List<Widget> _buildIndicator() {
  //   List<Widget> indicators = [];
  //   for (int i = 0; i < products.length; i++) {
  //     if (currentIndex == i) {
  //       indicators.add(_indicator(true));
  //     } else {
  //       indicators.add(_indicator(false));
  //     }
  //   }

  //   return indicators;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.velocity.pixelsPerSecond.dx > 0) {
                    // _preve();
                  } else if (details.velocity.pixelsPerSecond.dx < 0) {
                    //  _next();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 550,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              NetworkImage(widget.postDetail.data()['Url'][0]),
                          fit: BoxFit.cover)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                          Colors.grey[700].withOpacity(.9),
                          Colors.grey.withOpacity(.0),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 90,
                          margin: EdgeInsets.only(bottom: 60),
                          child: Row(
                              //children: _buildIndicator(),
                              ),
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: Transform.translate(
                  offset: Offset(0, -40),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.postDetail.data()['Title'],
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              widget.postDetail.data()['Type'],
                              style: TextStyle(
                                  color: Colors.yellow[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Text(
                          widget.postDetail.data()['Area'],
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.postDetail.data()['Address'],
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.postDetail.data()['Pincode'],
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.postDetail.data()['Price'],
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.postDetail.data()['Note'],
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 45,
                              // decoration: BoxDecoration(
                              //     color: Colors.yellow[700],
                              //     borderRadius: BorderRadius.circular(8)),
                              child: RaisedButton(
                                onPressed: () {
                                  //  Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               ChatScreen(),),
                                  //     );
                                },
                                elevation: 5.0,
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white,
                                child: Text(
                                  'Send Message',
                                  style: TextStyle(
                                    color: Color(0xFF527DAA),
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                              // Center(
                              //   child: Text(
                              //     "SEND REQUEST",

                              //     style: TextStyle(fontWeight: FontWeight.bold),
                              //   ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Container(
  //     child: Card(
  //       child: ListTile(
  //         title: Text(widget.postDetail.data()['Title']),
  //         subtitle: Text(widget.postDetail.data()['Area']),
  //       ),
  //     ),
  //   ));
  // }
}
