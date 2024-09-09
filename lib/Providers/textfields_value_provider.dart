import 'package:flutter/material.dart';

class TextFieldsValueProvider extends ChangeNotifier {
  String searchBySerial = "";
  String searchByModel = "";

  // ================ Type Machine Model ========================= //

  void typeMachineModel(String value) {
    searchByModel = value;
    notifyListeners();
  }

  // ================ Type Machine Serial ========================= //

  void typeMachineSerial(String value) {
    searchBySerial = value;
    notifyListeners();
  }
}
