import 'package:chataplication/commen_widget/platform_sensitive_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PlatfromAlertDialog extends PlatfromSensitive {
  final String title;
  final String content;
  final String continueText;
  final BuildContext context;

  PlatfromAlertDialog(
      {this.title, this.content, this.context, this.continueText});

  @override
  Widget buildAndroid() {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
        ],
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content),
        ],
      ),
      actions: [
        RaisedButton(
          child: Text(continueText),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget buildIOS() {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoButton(
          child: Text(continueText),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS == true ? buildIOS() : buildAndroid();
  }
}
