import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/pages/main/main_view.dart';

class MainComponent {
  final List<Widget> screens = [MainPage(), MainPage(), MainPage()];

  final List<DrawerDestination> drawerDestinations = [
    DrawerDestination("main", Icon(Icons.grid_on)),
    DrawerDestination("login", Icon(Icons.login)),
    DrawerDestination("settings", Icon(Icons.settings)),
  ];
}

class DrawerDestination {
  DrawerDestination(this.label, this.icon);

  final String label;
  final Widget icon;
}
