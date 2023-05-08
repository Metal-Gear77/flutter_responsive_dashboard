import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/utilities/style.dart';

import 'pages/main/main_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Responsive Dashboard',
      theme: MyStyle().lightTheme,
      darkTheme: MyStyle().darkTheme,
      home: MainPage(),
    );
  }
}
