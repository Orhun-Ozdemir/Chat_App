import 'package:chataplication/model/user.dart' as usermodel;
import 'package:chataplication/services/auth_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Future<usermodel.User> currentuser() async {
    User user = _firebaseauth.currentUser;
    return _userfromfirebase(user);
  }

  @override
  Future<usermodel.User> signInAnonymously() async {
    UserCredential userCredential = await _firebaseauth.signInAnonymously();
    return _userfromfirebase(userCredential.user);
  }

  @override
  Future<bool> signOut() async {
    try {
      if (_googleSignIn.currentUser != null) {
        await _googleSignIn.signOut();
      }
      await _firebaseauth.signOut();

      return true;
    } catch (e) {
      print("Firebase çıkış işlemminde hata" + e.toString());
      return false;
    }
  }

  usermodel.User _userfromfirebase(User user) {
    if (user == null) {
      return null;
    } else {
      print(user.uid);
      print(user.email);
      return usermodel.User(userId: user.uid, email: user.email);
    }
  }

  @override
  Future<usermodel.User> googleSignIn() async {
    GoogleSignInAccount _googleAccount = await _googleSignIn.signIn();
    if (_googleAccount != null) {
      GoogleSignInAuthentication _googleAuth =
          await _googleAccount.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential userCredential =
            await _firebaseauth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: _googleAuth.idToken,
              accessToken: _googleAuth.accessToken),
        );

        return _userfromfirebase(userCredential.user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<usermodel.User> signinwithEmailandPassword(
      String email, String password) async {
    UserCredential userdcredantial = await _firebaseauth
        .signInWithEmailAndPassword(email: email, password: password);
    return _userfromfirebase(userdcredantial.user);
  }

  @override
  Future<usermodel.User> createUserEmailandPassword(
      String email, String password) async {
    UserCredential usercredantial = await _firebaseauth
        .createUserWithEmailAndPassword(email: email, password: password);

    usermodel.User user = _userfromfirebase(usercredantial.user);
    return user;
  }
}
