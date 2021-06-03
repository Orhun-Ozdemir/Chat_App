import 'dart:ui';

import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final Widget icon;
  final double height;
  final double width;
  final double radius;
  final VoidCallback onPress;

  const SocialButton(
      {@required this.buttonColor,
      @required this.textColor,
      @required this.buttonText,
      @required this.icon,
      @required this.height,
      @required this.width,
      @required this.radius,
      @required this.onPress})
      : assert(buttonText != null, "Text Dergeri Null bir ifade");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: width,
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: onPress,
        color: buttonColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon == null ? Container() : icon,
            Text(
              "$buttonText",
              style: TextStyle(color: textColor),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
