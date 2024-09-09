import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/add_machine_details_provider.dart';
import 'package:provider/provider.dart';

class DataFetchFirebaseProvider extends ChangeNotifier {
  // Floor Name fetch from Firebase Firestore //
  List? floorName;

  void fetchFloor() async {
    DocumentSnapshot snapshotLine =
        await FirebaseFirestore.instance.collection("Sewing").doc("Line").get();

    floorName = List.from(snapshotLine["floor"]);

    notifyListeners();
  }

  // Machine Brand fetch from Firebase Firestore //
  List machineBrand = [];
  

  void fetchBrand(BuildContext context) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(
            Provider.of<AddMachineDetailsProvider>(context, listen: false)
                .machineType)
        .doc("Brand")
        .get();

    machineBrand = List.from(snapshotLine["machineBrand"]);

    notifyListeners();
  }

 

  // Machine Model fetch from Firebase Firestore //
  List? machineModel = [];

  void fetchModel(String brand, BuildContext context) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(
            Provider.of<AddMachineDetailsProvider>(context, listen: false)
                .machineType)
        .doc("Model")
        .get();

    machineModel = List.from(snapshotLine[brand]);

    notifyListeners();
  }

  // Machine Name fetch from Firebase Firestore //
  List? machineName = [];

  void fetchName(BuildContext context) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(
            Provider.of<AddMachineDetailsProvider>(context, listen: false)
                .machineType)
        .doc("Name")
        .get();

    machineName = List.from(snapshotLine["machineName"]);

    notifyListeners();
  }

  // Floor fetch from Firebase Firestore //
  List? floor = [];

  void fetchAllocatedFloor(BuildContext context) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(
            Provider.of<AddMachineDetailsProvider>(context, listen: false)
                .machineType)
        .doc("Line")
        .get();

    floor = List.from(snapshotLine["floor"]);

    notifyListeners();
  }

  // Floor fetch from Firebase Firestore //
  List? line = [];

  void fetchAllocatedLine(BuildContext context) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(
            Provider.of<AddMachineDetailsProvider>(context, listen: false)
                .machineType)
        .doc("Line")
        .get();

    line = List.from(snapshotLine["line"]);

    notifyListeners();
  }

  //  For Edit Floor Purpose, We have to fetch Floor name from Firestore Database but using selected Floor ..//
  // Floor fetch from Firebase Firestore //
  //

  // Machine Brand fetch from Firebase Firestore //
  List? machineBrandEdit = [];

  void fetchBrandEdit(BuildContext context, String machineType) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(machineType)
        .doc("Brand")
        .get();

    machineBrandEdit = List.from(snapshotLine["machineBrand"]);

    notifyListeners();
  }

  // Machine Model fetch from Firebase Firestore //
  List? machineModelEdit = [];

  void fetchModelEdit(
      String brand, BuildContext context, String machineType) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(machineType)
        .doc("Model")
        .get();

    machineModelEdit = List.from(snapshotLine[brand]);

    notifyListeners();
  }

  // Machine Name fetch from Firebase Firestore //
  List? machineNameEdit = [];

  void fetchNameEdit(BuildContext context, String machineType) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(machineType)
        .doc("Name")
        .get();

    machineNameEdit = List.from(snapshotLine["machineName"]);

    notifyListeners();
  }

  List? floorTo = [];

  void fetchShiftedToFloor(BuildContext context, machineType) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(machineType)
        .doc("Line")
        .get();

    floorTo = List.from(snapshotLine["floor"]);

    notifyListeners();
  }

  // Floor fetch from Firebase Firestore //
  List? lineTo = [];

  void fetchShiftedLineTo(BuildContext context, String machineType) async {
    DocumentSnapshot snapshotLine = await FirebaseFirestore.instance
        .collection(machineType)
        .doc("Line")
        .get();

    lineTo = List.from(snapshotLine["line"]);

    notifyListeners();
  }
  // =========================================================================================
  // ========================== Fetch Floor and Line for View Machine Screen ============== //
  // =========================================================================================

  // Line Data fetch //
  List viewMachineLine = [];

  void lineFetchForViewMachineScreen() async {
    DocumentSnapshot snapshotViewScreenLine =
        await FirebaseFirestore.instance.collection("Others").doc("Line").get();

    viewMachineLine = List.from(snapshotViewScreenLine["line"]);
    notifyListeners();
  }

  // Floor Data Fetch //
  List viewMachineFloor = [];

  void floorFetchForViewMachineScreen() async {
    DocumentSnapshot snapshotViewScreenFloor =
        await FirebaseFirestore.instance.collection("Others").doc("Line").get();

    viewMachineFloor = List.from(snapshotViewScreenFloor["floor"]);
    notifyListeners();
  }

  // Fetch Current user's Floor for Common Use//
  String? currentUserFloor;
  String? currentUserName;
  String? currentUserCardNo;
  String? currentUserFactory;
  String? currentUserEmail;
  String? currentUserSection;

  void fetchCurrentUserFloor(String uid) async {
    DocumentSnapshot currentFloorSnapshot =
        await FirebaseFirestore.instance.collection("UserData").doc(uid).get();

    currentUserFloor = currentFloorSnapshot["floorName"];
    currentUserName = currentFloorSnapshot["userName"];
    currentUserCardNo = currentFloorSnapshot["cardNo"];
    currentUserFactory = currentFloorSnapshot["factoryName"];
    currentUserEmail = currentFloorSnapshot["userEmail"];
    currentUserSection = currentFloorSnapshot["section"];

    notifyListeners();
  }

  //  ============================== Machine Count ===========================
  // =========================================================================
  int machineCount = 0;

  void countMachinePerFloor(BuildContext context) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(currentUserFactory!)
        .where("allocatedFloor", isEqualTo: currentUserFloor)
        .get();
    machineCount = querySnapshot.docs.length;
    notifyListeners();
  }
}
