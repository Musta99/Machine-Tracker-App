import 'package:flutter/material.dart';

class EditMachineDetailsProvider extends ChangeNotifier {
  String shiftedToFloor = "";

  void shiftedTo(String value) {
    shiftedToFloor = value;
    notifyListeners();
  }

  String? shiftedLine;

  void changeLine(String value) {
    shiftedLine = value;
    notifyListeners();
  }

  String? editMachineName;
  void changeMachineName(String value) {
    editMachineName = value;
    notifyListeners();
  }

  String? editMachineBrand;
  void changeMachineBrand(String value) {
    editMachineBrand = value;
    notifyListeners();
  }

  String? editMachineModel;
  void changeMachineModel(String value) {
    editMachineModel = value;
    notifyListeners();
  }
}
