import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/pages/settings/setting_provider.dart';
import 'package:flutter_responsive_dashboard/utilities/style.dart';
import 'package:provider/provider.dart';

import 'pages/main/main_view.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => SettingProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Responsive Dashboard',
      theme: context
          .watch<SettingProvider>()
          .state
          .selectedThemeData,
      home: MainPage(),
    );
  }
}
