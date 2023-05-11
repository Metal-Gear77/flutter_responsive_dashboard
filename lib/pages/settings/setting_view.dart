import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/pages/settings/setting_component.dart';
import 'package:provider/provider.dart';
import 'setting_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SettingProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final subjectState = context.watch<SettingProvider>().state;
    final subjectProvider = context.read<SettingProvider>();

    subjectProvider.initProvider();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(children: [
        SettingCard(
          child: Column(children: [
            SettingComponent().settingTitle(context, "UI 설정"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("테마 설정"),
                SettingComponent().selectThemeButton,
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
