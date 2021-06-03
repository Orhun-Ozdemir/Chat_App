import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

abstract class PlatfromSensitive extends StatelessWidget {
  Widget buildAndroid();
  Widget buildIOS();

  @override
  Widget build(BuildContext context) {
    Platform.isIOS == true ? buildIOS() : buildAndroid();
  }
}
