import 'package:chataplication/model/user.dart';
import 'package:chataplication/view/chat_room.dart';
import 'package:chataplication/view/dummypage/ornek1.dart';
import 'package:chataplication/view/waitingroom.dart';
import 'package:chataplication/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<User> _listusers = [];
  final _cloudfirestore = FirebaseFirestore.instance;
  User _lastuserId;

  Future<List<User>> getsomeuser(User lastuser) async {
    if (lastuser == null) {
      QuerySnapshot querySnapShot = await _cloudfirestore
          .collection("users")
          .orderBy("userId")
          .limit(10)
          .get();

      List<User> users =
          querySnapShot.docs.map((e) => User.fromMap(e.data())).toList();
      _listusers = users;

      _lastuserId = users.last;
      debugPrint("ahahhahahahahahh");
      debugPrint(_lastuserId.userName);

      return users;
    } else {
      QuerySnapshot tenusers = await _cloudfirestore
          .collection("users")
          .orderBy("userId")
          .limit(10)
          .startAfter([_lastuserId.userId]).get();

      if (tenusers == null) {
        return _listusers;
      } else {
        List<User> users =
            tenusers.docs.map((e) => User.fromMap(e.data())).toList();
        for (User user in users) {
          _listusers.add(user);
        }
        return _listusers;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          RaisedButton(
            child: Text("Cıkış"),
            onPressed: () {
              _userModel.signOut();
            },
          ),
          RaisedButton(
            child: Text("Ornek1"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ornek1()),
              );
            },
          )
        ],
        title: Text("UsersPage"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return Future.delayed(Duration(seconds: 1));
        },
        child: FutureBuilder(
          future: getsomeuser(_lastuserId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> users = snapshot.data;

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  if (users[index].userId != _userModel.user.userId) {
                    debugPrint(users[index].userId);
                    return GestureDetector(
                      onTap: () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).push(
                        MaterialPageRoute(
                          builder: (context) => Chat(
                            currentUser: _userModel.user,
                            otherUser: users[index],
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(users[index].userName),
                        subtitle: Text(users[index].email),
                        leading: Image.network(users[index].photoURL),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return WaitingRoom();
            }
          },
        ),
      ),
    );
  }
}
