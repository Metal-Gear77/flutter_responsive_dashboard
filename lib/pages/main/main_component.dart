import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/pages/home/home_view.dart';
import 'package:flutter_responsive_dashboard/pages/main/main_view.dart';
import 'package:flutter_responsive_dashboard/pages/settings/setting_view.dart';

class MainComponent {
  final List<Widget> screens = [HomePage(), SettingPage()];

  final List<DrawerDestination> drawerDestinations = [
    DrawerDestination("main", Icon(Icons.home)),
    DrawerDestination("settings", Icon(Icons.settings)),
  ];

  final Widget drawerBottom = SizedBox(
      height: 50,
      child: ListTile(
          leading: Text(
            "Log Out",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(onPressed: () {}, icon: Icon(Icons.logout))));

// NavigationDrawer(
//   onDestinationSelected: (int num) {
//     subjectProvider.setIndex(num);
//   },
//   elevation: 100,
//   selectedIndex: subjectState.selectedIndex,
//   children: [
//     UserAccountsDrawerHeader(
//         accountName: Text("accountName"),
//         accountEmail: Text("accountEmail"),
//         currentAccountPicture: CircleAvatar(
//           backgroundColor: Colors.blue,
//         )),
//     ...MainComponent()
//         .drawerDestinations
//         .map((e) => NavigationDrawerDestination(icon: e.icon, label: Text(e.label))),
//   ],
// ),
}

class DrawerDestination {
  DrawerDestination(this.label, this.icon);

  final String label;
  final Widget icon;
}
