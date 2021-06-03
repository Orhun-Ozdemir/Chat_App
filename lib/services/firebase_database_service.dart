import 'package:chataplication/model/message.dart';
import 'package:chataplication/model/user.dart';
import 'package:chataplication/services/database_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireBaseDatabase extends DBBase {
  final _cloudfirestore = FirebaseFirestore.instance;
  @override
  Future<User> saveUser(User user) async {
    try {
      Map<String, dynamic> mapuser = user.toMap();

      mapuser["createdTime"] = FieldValue.serverTimestamp();
      mapuser["updatedTime"] = FieldValue.serverTimestamp();

      await _cloudfirestore.collection("users").doc(user.userId).set(mapuser);
      return user;
    } catch (e) {
      debugPrint("CloudFirestore  user kaydetemede hata $e");
      return null;
    }
  }

  @override
  Future<User> readUser(String id) async {
    DocumentSnapshot doc =
        await _cloudfirestore.collection("users").doc(id).get();

    Map<String, dynamic> user = doc.data();
    return User.fromMap(user);
  }

  @override
  Future<User> updateUserName(String userId, String newname) async {
    await _cloudfirestore
        .collection("users")
        .doc(userId)
        .update({"userName": newname});

    return await readUser(userId);
  }

  Future<User> updateUserPhoto(String userId, String photoURL) async {
    await _cloudfirestore
        .collection("users")
        .doc(userId)
        .update({"photoURL": photoURL});
    return await readUser(userId);
  }

  @override
  Future<List<User>> getAllUser() async {
    CollectionReference collectionRefence = _cloudfirestore.collection("users");
    QuerySnapshot querySnapshot = await collectionRefence.get();
    List<User> users = querySnapshot.docs
        .map(
          (e) => User.fromMap(
            e.data(),
          ),
        )
        .toList();
    return users;
  }

  @override
  Stream getAllMessage(String userId, String otheruserId) {
    Stream<QuerySnapshot> querySnapShot = _cloudfirestore
        .collection("konusmalar")
        .doc(userId + "--" + otheruserId)
        .collection("mesajlar")
        .orderBy("date")
        .snapshots();

    return querySnapShot;
  }

  @override
  Future<bool> setMessage(Message mesaj) async {
    String mesajId = _cloudfirestore.collection("konusmalar").doc().id;
    Map<String, dynamic> mesajmap = mesaj.messagetoMap();
    mesajmap["date"] = FieldValue.serverTimestamp();
    await _cloudfirestore
        .collection("konusmalar")
        .doc(mesajmap["verici"] + "--" + mesajmap["alici"])
        .collection("mesajlar")
        .doc(mesajId)
        .set(mesajmap);
    mesajmap["bendenMi"] = false;

    await _cloudfirestore
        .collection("konusmalar")
        .doc(mesajmap["alici"] + "--" + mesajmap["verici"])
        .collection("mesajlar")
        .doc(mesajId)
        .set(mesajmap);

    return true;
  }
}
