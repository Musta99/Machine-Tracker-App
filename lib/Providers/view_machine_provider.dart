import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/textfields_value_provider.dart';
import 'package:provider/provider.dart';

class ViewMachineDetailProvider extends ChangeNotifier {
  String? selectedFactory;

  void selectFactory(String value) {
    selectedFactory = value;
    notifyListeners();
  }

  //== Floor Selection==
  String? selectedFloor;

  void selectFloor(String value) {
    selectedFloor = value;
    notifyListeners();
  }

  //== Line Selection==
  String? selectedLine;

  void selectLine(String value) {
    selectedLine = value;
    notifyListeners();
  }

  // ==Reset Line Selection ==
  TextEditingController lineController = TextEditingController();
  void resetLine() {
    selectedLine = null;
    lineController.text = '';
    notifyListeners();
  }

  // ======================================================================================
  // ======================================================================================
  //         Documents fetch from Firestore database for Floor and Line Combo
  // ======================================================================================
  // ======================================================================================
  List<DocumentSnapshot> documents = [];
  DocumentSnapshot? lastDocument;
  bool isLoading = false;
  bool hasMore = true;
  int docLimit = 5;

  // ================================================= //
  //    Fetch Initial Batch of Data
  // ================================================= //

  void fetchInitialBatch(BuildContext context) async {
    if (Provider.of<ViewMachineDetailProvider>(context, listen: false)
            .selectedLine ==
        null) {
      isLoading = true;
      notifyListeners();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              Provider.of<ViewMachineDetailProvider>(context, listen: false)
                  .selectedFactory!)
          .where("allocatedFloor",
              isEqualTo:
                  Provider.of<ViewMachineDetailProvider>(context, listen: false)
                      .selectedFloor)
          .orderBy("machineOrder")
          .limit(docLimit)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        notifyListeners();
      }

      documents = querySnapshot.docs;
      isLoading = false;
      hasMore = querySnapshot.docs.length == docLimit;
      notifyListeners();
    } else {
      isLoading = true;
      notifyListeners();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              Provider.of<ViewMachineDetailProvider>(context, listen: false)
                  .selectedFactory!)
          .where("allocatedFloor",
              isEqualTo:
                  Provider.of<ViewMachineDetailProvider>(context, listen: false)
                      .selectedFloor)
          .where("allocatedLine",
              isEqualTo:
                  Provider.of<ViewMachineDetailProvider>(context, listen: false)
                      .selectedLine)
          .orderBy("machineOrder")
          .limit(docLimit)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        notifyListeners();
      }

      documents = querySnapshot.docs;
      isLoading = false;
      hasMore = querySnapshot.docs.length == docLimit;
      notifyListeners();
    }
  }

  // ================================================= //
  //    Fetch Next Batch of Data
  // ================================================= //
  void fetchNextBatch(BuildContext context) async {
    if (!hasMore || isLoading) return;

    isLoading = true;
    notifyListeners();

    if (Provider.of<ViewMachineDetailProvider>(context, listen: false)
            .selectedLine ==
        null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              Provider.of<ViewMachineDetailProvider>(context, listen: false)
                  .selectedFactory!)
          .where("allocatedFloor",
              isEqualTo:
                  Provider.of<ViewMachineDetailProvider>(context, listen: false)
                      .selectedFloor)
          .orderBy("machineOrder")
          .startAfterDocument(lastDocument!)
          .limit(docLimit)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        notifyListeners();
      }

      documents.addAll(querySnapshot.docs);
      isLoading = false;
      hasMore = querySnapshot.docs.length == docLimit;
      notifyListeners();
    } else {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              Provider.of<ViewMachineDetailProvider>(context, listen: false)
                  .selectedFactory!)
          .where("allocatedFloor",
              isEqualTo:
                  Provider.of<ViewMachineDetailProvider>(context, listen: false)
                      .selectedFloor)
          .where("allocatedLine",
              isEqualTo:
                  Provider.of<ViewMachineDetailProvider>(context, listen: false)
                      .selectedLine)
          .orderBy("machineOrder")
          .startAfterDocument(lastDocument!)
          .limit(docLimit)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        notifyListeners();
      }

      documents.addAll(querySnapshot.docs);
      isLoading = false;
      hasMore = querySnapshot.docs.length == docLimit;
      notifyListeners();
    }
  }

  // ================================================= //
  //    Fetch Number of Machines in Container/Line
  // ================================================= //
  int numberOfMachines = 0;

  Future countMachines(BuildContext context) async {
    QuerySnapshot countSnapshot = await FirebaseFirestore.instance
        .collection(
            Provider.of<ViewMachineDetailProvider>(context, listen: false)
                .selectedFactory!)
        .where("allocatedFloor",
            isEqualTo:
                Provider.of<ViewMachineDetailProvider>(context, listen: false)
                    .selectedFloor)
        .where("allocatedLine",
            isEqualTo:
                Provider.of<ViewMachineDetailProvider>(context, listen: false)
                    .selectedLine)
        .get();

    numberOfMachines = countSnapshot.docs.length;
    notifyListeners();
  }

  // ======================================================================================
  // ======================================================================================
  //         Documents fetch from Firestore database for Floor and Model Combo
  // ======================================================================================
  // ======================================================================================
  // void fetchModelWise(BuildContext context) async {
  //   try {
  //     if (Provider.of<TextFieldsValueProvider>(context, listen: false)
  //             .searchByModel !=
  //         "") {
  //       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //           .collection(
  //               Provider.of<DataFetchFirebaseProvider>(context, listen: false)
  //                   .currentUserFactory!)
  //           .where("allocatedFloor",
  //               isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
  //                       listen: false)
  //                   .currentUserFloor!)
  //           .where("machineModel",
  //               isEqualTo:
  //                   Provider.of<TextFieldsValueProvider>(context, listen: false)
  //                       .searchByModel
  //                       .toUpperCase())
  //           .get();

  //       documents = querySnapshot.docs;
  //       notifyListeners();

  //       print("Successfully fetched");
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text(
  //             "Type Machine Model",
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   } catch (err) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text(
  //           err.toString(),
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // ======================================================================================
  // ======================================================================================
  //         Documents fetch from Firestore database for Floor and Serial Combo
  // ======================================================================================
  // ======================================================================================
  // void fetchSerialWise(BuildContext context) async {
  //   try {
  //     if (Provider.of<TextFieldsValueProvider>(context, listen: false)
  //             .searchBySerial !=
  //         "") {
  //       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //           .collection(
  //               Provider.of<DataFetchFirebaseProvider>(context, listen: false)
  //                   .currentUserFactory!)
  //           .where("allocatedFloor",
  //               isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
  //                       listen: false)
  //                   .currentUserFloor!)
  //           .where("machineSerial",
  //               isEqualTo:
  //                   Provider.of<TextFieldsValueProvider>(context, listen: false)
  //                       .searchBySerial
  //                       .toUpperCase())
  //           .get();

  //       documents = querySnapshot.docs;
  //       notifyListeners();

  //       print("Successfully fetched");
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text(
  //             "Type Machine Serial",
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   } catch (err) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text(
  //           err.toString(),
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }
}
