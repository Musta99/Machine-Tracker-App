class MachineModel {
  final String date;
  final String machineName;
  final String machineModel;
  final String machineType;
  final String machineBrand;
  final String machineSerial;
  final String factoryName;
  String? outFloor;
  final String allocatedFloor;
  String? allocatedLine;
  int machineOrder;
  String? note;
  String userName;
  String cardNo;

  MachineModel({
    required this.date,
    required this.machineName,
    required this.machineModel,
    required this.machineType,
    required this.machineBrand,
    required this.machineSerial,
    required this.factoryName,
    this.outFloor,
    required this.allocatedFloor,
    this.allocatedLine,
    required this.machineOrder,
    this.note,
    required this.userName,
    required this.cardNo,
  });

  Map<String, dynamic> toJson() => {
        "date": date,
        "machineName": machineName,
        "machineModel": machineModel,
        "machineType": machineType,
        "machineBrand": machineBrand,
        "machineSerial": machineSerial,
        "factoryName": factoryName,
        "outFloor": outFloor,
        "allocatedFloor": allocatedFloor,
        "allocatedLine": allocatedLine,
        "machineOrder": machineOrder,
        "note": note,
        "userName": userName,
        "cardNo": cardNo,
      };
}
