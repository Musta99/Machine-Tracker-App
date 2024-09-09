import 'package:flutter/material.dart';

class LandingScreenProvider extends ChangeNotifier {
  bool isVisible = false;

  void changeVisibility() {
    isVisible = true;
    notifyListeners();
  }
}
