import 'package:flutter/material.dart';

class AddMachineDetailsProvider extends ChangeNotifier {
  String? factoryName;

  void selectFectory(String value) {
    factoryName = value;
    notifyListeners();
  }

  //  =================== Machine Name =========================
  String? machineName;

  void selectMachine(String value) {
    machineName = value;
    notifyListeners();
  }

  //  =================== Machine Brand =========================
  String machineBrand = "";

  void selectBrand(String value) {
    machineBrand = value;
    notifyListeners();
  }

  //  =================== Machine Model=========================
  String? machineModel;

  void selectModel(String value) {
    machineModel = value;
    notifyListeners();
  }

  //  =================== Machine Type =========================
  String machineType = '';

  void selectType(String value) {
    machineType = value;
    notifyListeners();
  }

  //  =================== Machine Status =========================
  String? machineStatus;

  void selectStatus(String value) {
    machineStatus = value;
    notifyListeners();
  }

  //  =================== Out Machine Floor =========================
  String? machineOutFloor;

  void selectOutFloor(String value) {
    machineOutFloor = value;
    notifyListeners();
  }

  //  =================== Machine Allocated Floor =========================
  String? machineAllocatedFloor;

  void selectFloor(String value) {
    machineAllocatedFloor = value;
    notifyListeners();
  }

  //  =================== Machine Allocated Line =========================
  String? machineAllocatedLine;

  void selectLine(String value) {
    machineAllocatedLine = value;
    notifyListeners();
  }
}
