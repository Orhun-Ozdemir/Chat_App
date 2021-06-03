import 'package:chataplication/model/message.dart';
import 'package:chataplication/model/user.dart';
import 'package:chataplication/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  User currentUser;
  User otherUser;

  Chat({@required this.currentUser, @required this.otherUser});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Konusma"),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _userModel.getAllMessage(
                    widget.currentUser.userId, widget.otherUser.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment:
                              snapshot.data.docs[index]["bendenMi"] == false
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    bottom: 20, left: 10, top: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: snapshot.data.docs[index]
                                              ["bendenMi"] ==
                                          false
                                      ? Colors.red
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  snapshot.data.docs[index]["message"],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Text(
                              (snapshot.data.docs[index]["date"] as Timestamp)
                                      .toDate()
                                      .hour
                                      .toString() +
                                  "." +
                                  (snapshot.data.docs[index]["date"]
                                          as Timestamp)
                                      .toDate()
                                      .minute
                                      .toString(),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Container(child: Text("Dogru"));
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(37, 211, 102, 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textcontroller,
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    color: Colors.blue,
                    child: Text(
                      "PUSH",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (textcontroller.text.trim().length > 0) {
                        bool gittmi = await _userModel.setMessage(
                          Message(
                              message: textcontroller.text,
                              verici: widget.currentUser.userId,
                              alici: widget.otherUser.userId,
                              bendenMi: true),
                        );
                        if (gittmi) {
                          textcontroller.clear();
                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
