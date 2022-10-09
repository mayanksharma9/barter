import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class AddScreen extends StatefulWidget {
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Reference ref;
  bool uploading = false;
  double val = 0;
  DocumentReference imgRef;
  List<File> _image = [];

  // File _imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  final _formKeyScreen1 = GlobalKey<FormState>();
  TextEditingController Title = new TextEditingController();
  TextEditingController Area = new TextEditingController();
  TextEditingController Type = new TextEditingController();
  TextEditingController Address = new TextEditingController();
  TextEditingController Pincode = new TextEditingController();
  TextEditingController Note = new TextEditingController();

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    List<String> imageList = [];
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imageList.add(value);
          //imgRef.set({'url': imageList});
          i++;
        });
      });
    }
    Map<String, dynamic> data = {
      "Title": Title.text,
      "Area": Area.text,
      "Type": Type.text,
      "Address": Address.text,
      "Url": imageList,
      "Pincode": Pincode.text,
      "Note": Note.text,
      "Posted By": FirebaseAuth.instance.currentUser.displayName,
    };
    FirebaseFirestore.instance
        .collection("Post")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              showBottomSheet(
                  context: context,
                  builder: (context) => Container(
                        color: Colors.grey,
                        padding: EdgeInsets.only(
                            right: 24, left: 24, top: 32, bottom: 24),
                        child: ListView(),
                      ));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done_outlined),
        onPressed: () {
          _formKeyScreen1.currentState.validate();
          setState(() {
            uploading = true;
          });

          uploadFile();

          _formKeyScreen1.currentState.reset();
        },
      ),
      body: Container(
        //padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKeyScreen1,
              child: Center(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Titile';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      controller: Title,
                      decoration: InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Area';
                        }
                        return null;
                      },
                      controller: Area,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Area",
                          hintText: "Sq. Feet",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Type of Property';
                        }
                        return null;
                      },
                      controller: Type,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Type",
                          hintText: "Commercial,Residential etc.",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Address';
                        }
                        return null;
                      },
                      controller: Address,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                          labelText: "Address",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Pincode';
                        }
                        return null;
                      },
                      controller: Pincode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      minLines: 1,
                      decoration: InputDecoration(
                          labelText: "Pincode",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter offered price of Property';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: Type,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    TextFormField(
                      controller: Note,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                          labelText: "Note",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                    ),
                    // padding: EdgeInsets.all(4
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: _image.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Center(
                            child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () =>
                                    !uploading ? chooseImage() : null),
                          )
                        : Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_image[index - 1]),
                                    fit: BoxFit.cover)),
                          );
                  }),
            ),
          ],
          //   GridView.builder(
          // itemCount: _image.length + 1,
          // gridDelegate:
          //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          // itemBuilder: (context, index) {
          //   return index == 0
          //       ? Center(
          //           child: IconButton(
          //               icon: Icon(Icons.add),
          //               onPressed: () => !uploading ? chooseImage() : null),
          //         )
          //       : Container(
          //           margin: EdgeInsets.all(3),
          //           decoration: BoxDecoration(
          //               image: DecorationImage(
          //                   image: FileImage(_image[index - 1]),
          //                   fit: BoxFit.cover)),
          //         );
          // }),
        ),
      ),
      //  GridView.builder(
      //     itemCount: _image.length + 1,
      //     gridDelegate:
      //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      //     itemBuilder: (context, index) {
      //       return index == 0
      //           ? Center(
      //               child: IconButton(
      //                   icon: Icon(Icons.add),
      //                   onPressed: () => !uploading ? chooseImage() : null),
      //             )
      //           : Container(
      //               margin: EdgeInsets.all(3),
      //               decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                       image: FileImage(_image[index - 1]),
      //                       fit: BoxFit.cover)),
      //             );
      //     }),

      // RaisedButton(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30.0),
      //   ),
      //   onPressed: () {
      //     setState(() {
      //       uploading = true;
      //     });
      //     uploadFile();
      //     Map<String, dynamic> data = {
      //       "Title": Title.text,
      //       "Area": Area.text,
      //       "Type": Type.text,
      //       "Address": Address.text,
      //       "Url": imgRef.path,
      //     };
      //     FirebaseFirestore.instance.collection("Post").add(data);
      //     _formKeyScreen1.currentState.reset();
      //   },
      //   child: Text("Submit"),
      // ),

      // Column(
      //   children: [
      //     Center(
      //      // padding: EdgeInsets.all(4),
      //       child: GridView.builder(
      //           itemCount: _image.length + 1,
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 3),
      //           itemBuilder: (context, index) {
      //             return index == 0
      //                 ? Center(
      //               child: IconButton(
      //                   icon: Icon(Icons.add),
      //                   onPressed: () =>
      //                   !uploading ? chooseImage() : null),
      //             )
      //                 : Container(
      //               margin: EdgeInsets.all(3),
      //               decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                       image: FileImage(_image[index - 1]),
      //                       fit: BoxFit.cover)),
      //             );
      //           }),
      //         child: RaisedButton(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(30.0),
      //           ),
      //           onPressed: () {
      //             setState(() {
      //               uploading = true;
      //             });
      //             uploadFile();
      //             Map<String, dynamic> data = {
      //               "Title": Title.text,
      //               "Area": Area.text,
      //               "Type": Type.text,
      //               "Address": Address.text,
      //               "Url":  imgRef.path,
      //             };
      //             FirebaseFirestore.instance.collection("Post").add(data);
      //             _formKeyScreen1.currentState.reset();
      //           },
      //           child: Text("Submit"),
      //         )
      //
      //     ),
      //
      //   ],
      //
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    // imgRef = FirebaseFirestore.instance
    //     .collection('Post')
    //     .doc(FirebaseAuth.instance.currentUser.uid);
  }
}
