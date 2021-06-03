import 'package:chataplication/custom_navigationbar.dart';
import 'package:chataplication/view/profile.dart';
import 'package:chataplication/view/users.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem currentItem = TabItem.Users;
  final Map<TabItem, Widget> showingpage = {
    TabItem.Users: UsersPage(),
    TabItem.Profile: Profile(),
  };
  Map<TabItem, GlobalKey<NavigatorState>> navigatorkeys = {
    TabItem.Users: GlobalKey<NavigatorState>(),
    TabItem.Profile: GlobalKey<NavigatorState>(),
  };
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorkeys[currentItem].currentState.maybePop(),
      child: CustomNavigationBar(
        tabItem: currentItem,
        currentPage: showingpage,
        keys: navigatorkeys,
        onSelected: (item) {
          if (currentItem == item) {
            navigatorkeys[item].currentState.popUntil((route) => route.isFirst);
          } else {
            setState(
              () {
                currentItem = item;
              },
            );
          }
        },
      ),
    );
  }
}
