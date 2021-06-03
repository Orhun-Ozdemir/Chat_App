import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Message {
  final String message;
  final bool bendenMi;
  final String verici;
  final String alici;
  DateTime date;

  Message(
      {@required this.message,
      @required this.alici,
      @required this.verici,
      @required this.bendenMi});

  Map<String, dynamic> messagetoMap() => {
        "message": message,
        "bendenMi": bendenMi.toString(),
        "alici": alici,
        "verici": verici,
        "date": date ?? "",
      };

  Message.fromMap(Map<String, dynamic> map)
      : message = map["message"],
        bendenMi = map["bendenMi"],
        alici = map["alici"],
        verici = map["verici"],
        date = (map["date"] as Timestamp).toDate();
}
