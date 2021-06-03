import 'package:chataplication/view/sign_in/landing_page.dart';
import 'package:chataplication/services/locator.dart';
import 'package:chataplication/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setuplocator();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sunflower",
        theme: ThemeData(
          primaryColor: Colors.orangeAccent,
          primaryTextTheme: TextTheme(
            headline6:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //headline1: TextStyle(color: Colors.white),
          ),
        ),
        home: LandingPage(),
      ),
    ),
  );
}
