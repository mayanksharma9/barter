import 'package:barter/Helper/ReportFilter.dart';
import 'package:barter/Screen/DetailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class MainContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection("Post").snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView(
//             children: snapshot.data.docs.map((DocumentSnapshot document) {
//               return Container(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   document.data()['Title'],
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.more_vert),
//                           onPressed: () {
//                             showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(30),
//                                     topRight: Radius.circular(30),
//                                   ),
//                                 ),
//                                 builder: (context) => Container(
//                                       color: Colors.grey,
//                                       height: 150,
//                                       padding: EdgeInsets.only(
//                                           right: 24,
//                                           left: 24,
//                                           top: 32,
//                                           bottom: 24),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(),
//                                           Text(
//                                             "Report",
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 16,
//                                           ),
//                                           Text(
//                                             "Hide",
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ));
//                             //_bottomsheet();
//                           },
//                         ),
//                       ],
//                     )
//                     // Text(
//                     //   "Vadodara",
//                     //   style: TextStyle(
//                     //       fontSize: 12,
//                     //       fontWeight: FontWeight.bold,
//                     //       color: Colors.grey[500]),
//                     // )

//                     ,
//                     // title: new Text(document.data()['Title']),
//                     // subtitle: new Text(document.data()['Area']),
//                     // child: Container(
//                     //   width: MediaQuery.of(context).size.width / 1.2,
//                     //   height: MediaQuery.of(context).size.height / 6,
//                     //   child: Text(document['Title']),
//                     // ),
//                     Stack(
//                       children: [
//                         Container(
//                             height: MediaQuery.of(context).size.width - 50,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(30),
//                               boxShadow: [
//                                 // BoxShadow(
//                                 // color: Colors.black.withOpacity(0.3),
//                                 // spreadRadius: 2,
//                                 // blurRadius: 20,
//                                 // offset: Offset(0, 10),
//                                 // ),
//                               ],
//                               // image: DecorationImage(
//                               // fit: BoxFit.cover,
//                               // //image: NetworkImage(document.data()['Image']
//                               // )
//                             )),
//                         // Positioned(
//                         // bottom: 20,
//                         // left: 20,
//                         // child: Icon(Icons.favorite_border,
//                         // size: 35,
//                         // color: Colors.white.withOpacity(0.7)),
//                         // ),
//                         Positioned(child: Text(document.data()['Type']))
//                       ],
//                     )
//                   ],
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );

//     // return Column(
//     //   crossAxisAlignment: CrossAxisAlignment.start,
//     //   children: <Widget>[
//     //     Padding(
//     //       padding: const EdgeInsets.symmetric(horizontal: 20),
//     //     ),
//     //     //Categories(),
//     //     Expanded(
//     //       child: Padding(
//     //         padding: const EdgeInsets.symmetric(horizontal: 20),
//     //         child: ListView.builder(
//     //             itemCount: ads.length,
//     //             itemBuilder: (context,index) => Item(ads: ads[index],)
//     //         ),
//     // ),

//     //     ),
//     //   ],
//     // );
//   }
// void _bottomsheet() {
//   showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Wrap(
//           children: [
//             ReportFilter(),
//           ],
//         );
//       });
// }
// }

class Maincontent extends StatefulWidget {
  @override
  _MaincontentState createState() => _MaincontentState();
}

class _MaincontentState extends State<Maincontent> {
  List<NetworkImage> _listOfImages = [];
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.settings = Settings(
        persistenceEnabled: false,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Post")
              .snapshots(includeMetadataChanges: true),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading"),
              );
            } else {
              return ListView.builder(
                  cacheExtent: 9999,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                    // _listOfImages = [];
                    // for (int i = 0;
                    //     i < snapshot.data.docs[index].data()['Url'].length;
                    //     //i++
                    //     ) {
                    //   _listOfImages.add(NetworkImage(
                    //       snapshot.data.docs[index].data()['Url'][i]));
                    // }
                    return new GestureDetector(
                      //You need to make my child interactive
                      onTap: () => navigateToDetail(snapshot.data.docs[index]),
                      child: new Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     IconButton(
                            //       icon: Icon(Icons.more_vert_outlined),
                            //       onPressed: () {},
                            //     ),
                            //   ],
                            // ),

                            ListTile(
                              trailing: IconButton(
                                  icon: Icon(Icons.more_vert_outlined),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                        ),
                                        builder: (context) {
                                          return Wrap(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 24,
                                                    left: 24,
                                                    top: 10,
                                                    bottom: 24),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    title: new Text(
                                                      'Report',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    onTap: () {},
                                                  ),
                                                  ListTile(
                                                    title: new Text(
                                                      'Hide',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    onTap: () {},
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
                                  }),
                              title: Text(
                                documentSnapshot['Title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                documentSnapshot['Address'],
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                              ),
                            ),

                            Image.network(
                              // _listOfImages,
                              documentSnapshot["Url"][0],
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                documentSnapshot['Area'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Row(
                              children: [
                                // ButtonBar(
                                //   alignment: MainAxisAlignment.start,
                                //   children: [
                                //     FlatButton(
                                //       textColor: const Color(0xFF6200EE),
                                //       onPressed: () {
                                //         // Perform some action
                                //       },
                                //       child: const Text('ACTION 1'),
                                //     ),
                                //     FlatButton(
                                //       textColor: const Color(0xFF6200EE),
                                //       onPressed: () {
                                //         // Perform some action
                                //       },
                                //       child: const Text('ACTION 2'),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),

                            //         //         image: NetworkImage(documentSnapshot['Url']),
                            //         //         fit: BoxFit.cover,
                            //         //       ),
                            //         Container(
                            //          decoration: BoxDecoration(
                            //            borderRadius: BorderRadius.circular(20),
                            // image: DecorationImage(
                            //                 image: NetworkImage(documentSnapshot['Url']),
                            //                  fit: BoxFit.cover,
                            //                ),

                            // Image.asset('assets/card-sample-image.jpg'),
                            // Image.asset('assets/card-sample-image-2.jpg'),
                          ],
                        ),
                      ),
                      // //I am the clickable child
                      // elevation: 20,
                      // color: Colors.amber,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(50),
                      // ),
                      // child: new Container(

                      //   height: 250,
                      //   width: double.infinity,
                      //   padding: EdgeInsets.all(20),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       image: DecorationImage(
                      //         image: NetworkImage(documentSnapshot['Url']),
                      //         fit: BoxFit.cover,
                      //       ),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: Colors.grey[400],
                      //             blurRadius: 10,
                      //             offset: Offset(0, 10))
                      //       ]),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Row(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           Expanded(
                      //             child: Column(
                      //               children: <Widget>[
                      //                 Text(
                      //                   documentSnapshot['Title'],
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 38,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 10,
                      //                 ),
                      //                 Text(
                      //                   documentSnapshot["Area"],
                      //                   style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontSize: 20),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       // Text(
                      //       //   documentSnapshot["Price"],
                      //       //   style: TextStyle(
                      //       //       color: Colors.white,
                      //       //       fontSize: 30,
                      //       //       fontWeight: FontWeight.bold),
                      //       // )
                      //     ],
                      //   ),
                      // ),

                      // // children: <Widget>[
                      // //   new Image.network(documentSnapshot['Url'],fit: BoxFit.cover,),
                      // //   new Padding(padding: new EdgeInsets.all(3.0)),
                      // //   new Text(documentSnapshot['Title'],
                      // //     style: new TextStyle(fontWeight: FontWeight.bold,
                      // //         color: Colors.black),
                      // //   ),

                      // // ],
                    );

                    // return ListTile(
                    //   // contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    //   // leading: Container(
                    //   //   padding: EdgeInsets.only(right: 12.0),
                    //   //   decoration: new BoxDecoration(
                    //   //     border: new Border(
                    //   //       right: new BorderSide(width: 1.0 , color: Colors.white24)
                    //   //     )
                    //   //   ),
                    //   // ),
                    //   title: Text(documentSnapshot['Title']),
                    //   onTap: () => navigateToDetail(snapshot.data.docs[index]),
                    // );
                  });
            }
          }),
    );
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  postDetail: post,
                )));
  }
}
