import 'package:chataplication/model/user.dart';

abstract class AuthBase {
  Future<User> currentuser();
  Future<User> signInAnonymously();
  Future<bool> signOut();
  Future<User> googleSignIn();
  Future<User> signinwithEmailandPassword(String email, String password);
  Future<User> createUserEmailandPassword(String email, String password);
}
