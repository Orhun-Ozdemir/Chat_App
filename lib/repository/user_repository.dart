import 'dart:io';

import 'package:chataplication/model/message.dart';
import 'package:chataplication/model/user.dart';
import 'package:chataplication/services/auth_base.dart';
import 'package:chataplication/services/fake_auth_service.dart';
import 'package:chataplication/services/firebase_auth_service.dart';
import 'package:chataplication/services/firebase_database_service.dart';
import 'package:chataplication/services/firebase_storage.dart';
import 'package:chataplication/services/locator.dart';

enum Durum {
  DEBUG,
  RELEASE,
}

class UserRepository implements AuthBase {
  final FireBaseAuthService _fireBaseAuthService = getit<FireBaseAuthService>();
  final FakeAuthService _fakeAuthService = getit<FakeAuthService>();
  final FireBaseDatabase _fireBaseDatabase = getit<FireBaseDatabase>();
  final FireBaseStorage _fireBaseStorage = getit<FireBaseStorage>();
  Durum _durum = Durum.RELEASE;
  @override
  Future<User> currentuser() async {
    if (_durum == Durum.RELEASE) {
      User user = await _fireBaseAuthService.currentuser();
      return await _fireBaseDatabase.readUser(user.userId);
    } else {
      return await _fakeAuthService.currentuser();
    }
  }

  @override
  Future<User> signInAnonymously() async {
    return _durum == Durum.RELEASE
        ? await _fireBaseAuthService.signInAnonymously()
        : await _fakeAuthService.signInAnonymously();
  }

  @override
  Future<bool> signOut() async {
    return _durum == Durum.RELEASE
        ? await _fireBaseAuthService.signOut()
        : await _fakeAuthService.signOut();
  }

  @override
  Future<User> googleSignIn() async {
    if (_durum == Durum.RELEASE) {
      User user = await _fireBaseAuthService.googleSignIn();
      await _fireBaseDatabase.saveUser(user);
      return user;
    } else {
      return await _fakeAuthService.googleSignIn();
    }
  }

  @override
  Future<User> signinwithEmailandPassword(String email, String password) async {
    if (_durum == Durum.RELEASE) {
      User user = await _fireBaseAuthService.signinwithEmailandPassword(
          email, password);
      _fireBaseDatabase.readUser(user.userId);
    }
    {
      return await _fakeAuthService.signinwithEmailandPassword(email, password);
    }
  }

  @override
  Future<User> createUserEmailandPassword(String email, String password) async {
    if (_durum == Durum.RELEASE) {
      User user = await _fireBaseAuthService.createUserEmailandPassword(
          email, password);
      await _fireBaseDatabase.saveUser(user);
      return _fireBaseDatabase.readUser(user.userId);
    } else {
      return await _fakeAuthService.createUserEmailandPassword(email, password);
    }
  }

  Future<User> updateUserName(String userId, String newname) async {
    if (_durum == Durum.RELEASE) {
      return await _fireBaseDatabase.updateUserName(userId, newname);
    } else {
      return null;
    }
  }

  Future<String> uploadImage(String userId, String fileName, File file) async {
    String url = await _fireBaseStorage.uploadImage(userId, fileName, file);
    if (url == null) {
      return null;
    } else {
      await _fireBaseDatabase.updateUserPhoto(userId, url);
      return url;
    }
  }

  Future<List<User>> getAllUsers() async {
    return _durum == Durum.RELEASE
        ? await _fireBaseDatabase.getAllUser()
        : null;
  }

  Stream getAllMessage(String userId, String otheruserId) {
    if (_durum == Durum.RELEASE) {
      return _fireBaseDatabase.getAllMessage(userId, otheruserId);
    } else {
      return null;
    }
  }

  Future<bool> setMessage(Message mesaj) async {
    return _durum == Durum.RELEASE
        ? await _fireBaseDatabase.setMessage(mesaj)
        : null;
  }
}
