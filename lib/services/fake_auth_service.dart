import 'package:chataplication/model/user.dart';
import 'package:chataplication/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  @override
  Future<User> currentuser() {
    return Future.value(User(userId: "123456", email: "email"));
  }

  @override
  Future<User> signInAnonymously() {
    return Future.delayed(
      Duration(seconds: 2),
      () => User(userId: "123456", email: "email"),
    );
  }

  @override
  Future<bool> signOut() {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<User> googleSignIn() {
    return Future.delayed(
        Duration(seconds: 2), () => User(userId: "12345", email: "email"));
  }

  @override
  Future<User> signinwithEmailandPassword(String email, String password) {
    return Future.delayed(
      Duration(seconds: 2),
      () => User(userId: "signwith_form_123456", email: "email"),
    );
  }

  @override
  Future<User> createUserEmailandPassword(String email, String password) {
    return Future.delayed(
      Duration(seconds: 2),
      () => User(userId: "signwith_form_123456", email: "email"),
    );
  }
}
