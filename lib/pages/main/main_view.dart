import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/pages/main/main_component.dart';
import 'package:provider/provider.dart';

import '../../utilities/responsives.dart';
import 'main_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MainProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final subjectState = context.watch<MainProvider>().state;
    final subjectProvider = context.read<MainProvider>();

    Widget navigationDrawer = SizedBox(
      width: 250,
      child: NavigationDrawer(
        onDestinationSelected: (int num) {
          subjectProvider.setIndex(num);
        },
        selectedIndex: subjectState.selectedIndex,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("accountName"),
              accountEmail: Text("accountEmail"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
              )),
          ...MainComponent().drawerDestinations.map((e) => NavigationDrawerDestination(
                icon: e.icon,
                label: Text(e.label),
              ))
        ],
      ),
    );
    AppBar appBar = AppBar(
      title: Center(child: Text("Title")),
    );

    return Scaffold(
      appBar: Responsive.isMobile(context) || Responsive.isTablet(context) ? appBar : null,
      drawer:
          Responsive.isMobile(context) || Responsive.isTablet(context) ? navigationDrawer : null,
      body: Row(
        children: [
          if (Responsive.isDesktop(context)) navigationDrawer,
          Expanded(
              child: Column(
            children: [if (Responsive.isDesktop(context)) appBar, Expanded(child: Placeholder())],
          ))
        ],
      ),
    );
  }
}
