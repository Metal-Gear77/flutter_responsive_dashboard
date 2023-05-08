import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  final state = MainState();

  void setIndex(int num) {
    state.selectedIndex = num;
    notifyListeners();
  }
}

class MainState {
  late int selectedIndex;

  MainState() {
    selectedIndex = 0;
  }
}
