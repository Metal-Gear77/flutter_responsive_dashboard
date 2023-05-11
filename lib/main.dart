import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/pages/settings/setting_provider.dart';
import 'package:flutter_responsive_dashboard/utilities/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/main/main_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  initState() {
    themeNotifier = ValueNotifier(SettingProvider().state.themeList[0].themeData);
    SettingProvider().getSavedTheme().then((value) {
      if (value != null) {
        themeNotifier.value = SettingState()
            .themeList
            .elementAt(SettingState().themeList.indexWhere((element) => element.themeName == value))
            .themeData;
      }
    });

    super.initState();
  }

  static late final ValueNotifier<ThemeData> themeNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
        valueListenable: themeNotifier,
        builder: (_, ThemeData themeData, __) {
          return MaterialApp(
            title: 'Flutter Responsive Dashboard',
            theme: themeData,
            home: MainPage(),
          );
        });
  }
}
