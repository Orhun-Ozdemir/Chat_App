import 'package:chataplication/model/message.dart';
import 'package:chataplication/model/user.dart';

abstract class DBBase {
  Future<User> saveUser(User user);
  Future<User> readUser(String id);
  Future<User> updateUserName(String userId, String newname);
  Future<User> updateUserPhoto(String userId, String photoURL);
  Future<List<User>> getAllUser();
  Stream getAllMessage(String userId, String otheruserId);
  Future<bool> setMessage(Message mesaj);
}
