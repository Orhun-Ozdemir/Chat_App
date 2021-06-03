import 'package:chataplication/commen_widget/social_log_in_button.dart';
import 'package:chataplication/view/sign_in/sign_up_page.dart';
import 'package:chataplication/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _usermodel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("SUNFLOWER"),
        textTheme: Theme.of(context).primaryTextTheme,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Anonim giriş
            SocialButton(
                buttonColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                buttonText: "ANONİM",
                icon: Icon(Icons.wb_sunny),
                height: 50,
                width: 50,
                radius: 10,
                onPress: () => _usermodel.signInAnonymously()),
            // Google Button
            SocialButton(
              buttonColor: Colors.red,
              textColor: Colors.white,
              buttonText: "Google",
              icon: Image.network(
                "https://img-authors.flaticon.com/google.jpg",
                height: 35,
              ),
              height: 50,
              width: 50,
              radius: 10,
              onPress: () {
                _usermodel.googleSignIn();
              },
            ),
            // FaceBook Button
            SocialButton(
              buttonColor: Colors.blue[800],
              textColor: Colors.white,
              buttonText: "Facebook",
              icon: Icon(Icons.book),
              height: 40,
              width: null,
              radius: 16,
              onPress: () {},
            ),
            // SunFlower Button
            SocialButton(
              buttonColor: Colors.orangeAccent,
              textColor: Colors.white,
              buttonText: "SUNFLOWER",
              icon: Icon(Icons.dangerous),
              height: 40,
              width: null,
              radius: 16,
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
