import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  String userName;
  String email;
  String password;
  DateTime creadtedTime;
  DateTime updatedTime;
  String photoURL;

  User({
    @required this.userId,
    @required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "email": email,
      "userName": userName,
      "createdTime": creadtedTime ?? "",
      "updatedTime": updatedTime ?? "",
      "photoURL": photoURL ?? "",
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userId = map["userId"],
        userName = map["userName"],
        email = map["email"],
        photoURL = map["photoURL"],
        creadtedTime = (map["createdTime"] as Timestamp).toDate(),
        updatedTime = (map["updatedTime"] as Timestamp).toDate();
}
