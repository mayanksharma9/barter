import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String ID;
  String UserName;
  String Name;
  String Email;
  String PhoneNumber;
  String ProfilePicture;
  int Posts;
  Timestamp CreationDate;

  UserData({this.ID,
    this.UserName,
    this.Name,
    this.Email,
    this.PhoneNumber,
    this.ProfilePicture,
    this.Posts,
    this.CreationDate,});
}