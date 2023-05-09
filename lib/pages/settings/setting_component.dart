import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/pages/settings/setting_provider.dart';
import 'package:provider/provider.dart';

class SettingComponent {
  Widget selectThemeButton = Consumer<SettingProvider>(
    builder: (context, provider, child) {
      return DropdownButton(
          value: provider.state.selectedThemeName,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            provider.setTheme(value!);
          },
          items: provider.state.dropdownMenuItem);
    },
  );
}
