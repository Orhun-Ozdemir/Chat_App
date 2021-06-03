import 'package:chataplication/services/firebase_auth_service.dart';
import 'package:chataplication/view/sign_in/sign_in_page.dart';
import 'package:chataplication/viewmodel/user_model.dart';
import 'package:chataplication/view/waitingroom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chataplication/view/home_page.dart';

class LandingPage extends StatefulWidget {
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    Provider.of<UserModel>(context, listen: false)
        .currentuser()
        .then((value) => value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _usermodel = Provider.of<UserModel>(context);

    if (_usermodel.state == Status.Busy) {
      return WaitingRoom();
    } else {
      if (_usermodel.user == null) {
        return SignPage();
      } else {
        return HomePage(_usermodel.user);
      }
    }
  }
}
