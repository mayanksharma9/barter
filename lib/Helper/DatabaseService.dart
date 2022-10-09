import 'package:barter/Helper/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid;
  final CollectionReference Users =
  FirebaseFirestore.instance.collection("Users");

  UserData userData;

  DatabaseService({this.uid});

//User creation in Database
  Future createUser({UserData userData}) async {
    return await Users.doc(uid).set(toMap(userData));
  }

  Map toMap(UserData userData) {
    var data = Map<String, dynamic>();
    data['Uid'] = FirebaseAuth.instance.currentUser.uid;
    data['Email'] = userData.Email;
    data['UserName'] = userData.UserName;
    data['Posts'] = userData.Posts;
    data['Name'] = userData.Name;
    data['CreationDate'] = userData.CreationDate;
    data['PhoneNumber'] = userData.PhoneNumber;
    return data;
  }
}