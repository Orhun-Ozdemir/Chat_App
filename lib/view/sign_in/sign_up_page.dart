import 'package:chataplication/commen_widget/platform_sensitive_alertdialog.dart';
import 'package:chataplication/commen_widget/text_field.dart';
import 'package:chataplication/error_message/error_message.dart';
import 'package:chataplication/view/waitingroom.dart';
import 'package:chataplication/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FormType { Login, Register }

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _key = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontoller = TextEditingController();
  TextEditingController repasswordcontoller = TextEditingController();
  String email;
  String password;
  var user;
  FormType formtype = FormType.Login;

  void submitform(UserModel userModel) async {
    if (formtype == FormType.Login) {
      try {
        user = await userModel.signinwithEmailandPassword(
            emailcontroller.text, passwordcontoller.text);
      } on FirebaseAuthException catch (e) {
        PlatfromAlertDialog(
          title: "Hata",
          content: e.code,
          context: context,
          continueText: "Tamam",
        ).build(context);
      }
    } else {
      try {
        user = await userModel.createUserEmailandPassword(
            emailcontroller.text, passwordcontoller.text);
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return PlatfromAlertDialog(
                title: "Hata",
                content: ErrorMessage.translatemessage(e.code),
                context: context,
                continueText: "Tamam",
              ).build(context);
            });
      }
    }

    if (user != null) {
      Navigator.pop(context);
    }
    debugPrint("${emailcontroller.text}  and ${passwordcontoller.text}");
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    return _userModel.state == Status.Idle
        ? Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width * 0.25 / 10),
                    width: MediaQuery.of(context).size.width * 9.5 / 10,
                    height: MediaQuery.of(context).size.height * 7.5 / 10,
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      boxShadow: [],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Form(
                      key: _key,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextPart(
                              controller: emailcontroller,
                              value: email,
                              erorrText: _userModel.emailerror,
                              labelText: "Email",
                              textcolor: Colors.yellow[700],
                              cheight:
                                  MediaQuery.of(context).size.height * 1.1 / 10,
                              radius: 8,
                            ),
                            TextPart(
                              secure: true,
                              controller: passwordcontoller,
                              erorrText: _userModel.passwordError,
                              value: password,
                              labelText: "Password",
                              textcolor: Colors.yellow[700],
                              cheight: MediaQuery.of(context).size.height *
                                  0.85 /
                                  10,
                              radius: 8,
                            ),
                            formtype == FormType.Login
                                ? SizedBox()
                                : TextPart(
                                    controller: repasswordcontoller,
                                    labelText: "RePassword",
                                    textcolor: Colors.yellow[700],
                                    cheight:
                                        MediaQuery.of(context).size.height *
                                            0.85 /
                                            10,
                                    radius: 8,
                                  ),
                            RaisedButton(
                              onPressed: () async {
                                submitform(_userModel);
                              },
                              child: Text(formtype == FormType.Login
                                  ? "Login"
                                  : "Register"),
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  formtype == FormType.Login
                                      ? formtype = FormType.Register
                                      : formtype = FormType.Login;
                                });
                              },
                              child: Text(formtype == FormType.Login
                                  ? "Hesabınız yoksa Kayıt olun"
                                  : "Hesabınız varsa Giriş yapabilirsiniz"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : WaitingRoom();
  }
}
