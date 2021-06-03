import 'package:chataplication/view/dummypage/ornek2.dart';
import 'package:flutter/material.dart';

class Ornek1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orenk1"),
        actions: [
          RaisedButton(
            child: Text("Ornek2"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Ornek2(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
