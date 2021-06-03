import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { Users, Profile }

class CustomNavigationBar extends StatelessWidget {
  final TabItem tabItem;
  final ValueChanged<TabItem> onSelected;
  final Map<TabItem, Widget> currentPage;
  final Map<TabItem, GlobalKey<NavigatorState>> keys;
  CustomNavigationBar(
      {@required this.tabItem,
      @required this.onSelected,
      @required this.currentPage,
      @required this.keys});

  BottomNavigationBarItem _bottomNavigationBarItem(TabItem item) {
    return BottomNavigationBarItem(
        label: TabItemData.tabledata[item].title,
        icon: TabItemData.tabledata[item].icon);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        return CupertinoTabView(
          navigatorKey: keys[TabItem.values[index]],
          builder: (context) => currentPage[TabItem.values[index]],
        );
      },
      tabBar: CupertinoTabBar(
        items: [
          _bottomNavigationBarItem(TabItem.Users),
          _bottomNavigationBarItem(TabItem.Profile),
        ],
      ),
    );
  }
}

class TabItemData {
  final Icon icon;
  final String title;

  TabItemData(this.icon, this.title);

  static Map<TabItem, TabItemData> tabledata = {
    TabItem.Users:
        TabItemData(Icon(Icons.supervised_user_circle_sharp), "User"),
    TabItem.Profile: TabItemData(Icon(Icons.verified_user), "Profile"),
  };
}
