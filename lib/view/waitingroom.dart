import 'package:flutter/material.dart';

class WaitingRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Center(
        child: CircularProgressIndicator(
          value: 10,
        ),
      )),
    );
  }
}
