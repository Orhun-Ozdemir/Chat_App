import 'dart:io';

import 'package:chataplication/model/message.dart';
import 'package:chataplication/model/user.dart';
import 'package:chataplication/repository/user_repository.dart';
import 'package:chataplication/services/auth_base.dart';
import 'package:chataplication/services/locator.dart';
import 'package:flutter/cupertino.dart';

enum Status { Idle, Busy }

class UserModel with ChangeNotifier implements AuthBase {
  UserRepository _userrepository = getit<UserRepository>();
  Status _state = Status.Idle;
  String emailerror;
  String passwordError;
  User user;

  get state => _state;

  set state(Status state) {
    _state = state;
    notifyListeners();
  }

  @override
  Future<User> currentuser() async {
    try {
      state = Status.Busy;
      user = await _userrepository.currentuser();
      return user;
    } catch (e) {
      debugPrint("USERMODEL CURRENT USER HATA $e");
      return null;
    } finally {
      state = Status.Idle;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    try {
      state = Status.Busy;
      user = await _userrepository.signInAnonymously();
      return user;
    } catch (e) {
      debugPrint("USERMODEL ANONİM GİRİŞ HATA" + "$e");
      return null;
    } finally {
      state = Status.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = Status.Busy;

      return await _userrepository.signOut().then((value) {
        user = null;
        return value;
      });
    } catch (e) {
      debugPrint("USERMODEL ÇIKŞ HAT $e");
      return false;
    } finally {
      state = Status.Idle;
    }
  }

  @override
  Future<User> googleSignIn() async {
    try {
      state = Status.Busy;
      user = await _userrepository.googleSignIn();
      return user;
    } catch (e) {
      debugPrint("UserModel hata google sign in  $e");
      return null;
    } finally {
      state = Status.Idle;
    }
  }

  bool checkform(String email, String password) {
    if (email.contains("@") == true) {
      emailerror = null;
    } else {
      emailerror = "Email hatalı";
      return false;
    }

    if (password.length < 6) {
      passwordError = "Sifre 6 karakterden küçük olamaz";
      return false;
    } else {
      passwordError = null;
    }

    return true;
  }

  @override
  Future<User> signinwithEmailandPassword(String email, String password) async {
    try {
      state = Status.Busy;
      if (checkform(email, password) == false) {
        state = Status.Idle;
        return null;
      } else {
        user =
            await _userrepository.signinwithEmailandPassword(email, password);
        return user;
      }
    } finally {
      state = Status.Idle;
    }
  }

  @override
  Future<User> createUserEmailandPassword(String email, String password) async {
    try {
      state = Status.Busy;
      if (checkform(email, password) == true) {
        user =
            await _userrepository.createUserEmailandPassword(email, password);

        return user;
      } else {
        state = Status.Idle;
        return null;
      }
    } finally {
      state = Status.Idle;
    }
  }

  Future<bool> updateUserName(String userId, String newname) async {
    user = await _userrepository.updateUserName(userId, newname);
    if (user != null) {
      return true;
    } else
      return false;
  }

  Future<String> uploadImage(String userId, String fileName, File file) async {
    return await _userrepository.uploadImage(userId, fileName, file);
  }

  Future<List<User>> getAllUsers() async {
    return await _userrepository.getAllUsers();
  }

  Stream getAllMessage(String userId, String otheruserId) {
    return _userrepository.getAllMessage(userId, otheruserId);
  }

  Future<bool> setMessage(Message mesaj) async {
    return _userrepository.setMessage(mesaj);
  }
}
