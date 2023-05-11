import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_dashboard/main.dart';
import 'package:flutter_responsive_dashboard/utilities/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  final state = SettingState();

  void initProvider() {
    getSavedTheme().then((value) {
      if (value != null) {
        setTheme(value);
      }
    });
  }

  setTheme(String selectedItem) async {
    final prefs = await SharedPreferences.getInstance();

    state.selectedThemeName = selectedItem;
    state.selectedThemeData = state.themeList
        .elementAt(state.themeList.indexWhere((element) => element.themeName == selectedItem))
        .themeData;
    MyAppState.themeNotifier.value = state.selectedThemeData;
    prefs.setString("savedTheme", selectedItem);
    notifyListeners();
  }

  Future<String?> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("savedTheme");
  }
}

class SettingState {
  late String selectedThemeName;
  late ThemeData selectedThemeData;

  late List<DropdownMenuItem<String>> dropdownMenuItem;
  final List<ThemeListModel> themeList = [
    ThemeListModel(
        "lightTheme",
        FlexThemeData.light(
          scheme: FlexScheme.materialBaseline,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useM2StyleDividerInM3: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
        )),
    ThemeListModel(
        "darkTheme",
        FlexThemeData.dark(
          scheme: FlexScheme.materialBaseline,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 13,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            useM2StyleDividerInM3: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
        ))
  ];

  //https://rydmike.com/flexcolorscheme/themesplayground-v7/#/

  SettingState() {
    selectedThemeData = themeList[0].themeData;
    selectedThemeName = themeList[0].themeName;

    dropdownMenuItem = themeList
        .map((value) => DropdownMenuItem(
              value: value.themeName,
              child: Text(value.themeName),
            ))
        .toList();
  }
}

class ThemeListModel {
  final String themeName;
  final ThemeData themeData;

  ThemeListModel(this.themeName, this.themeData);
}
