import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:provider/provider.dart';

class TransferMachineProvider extends ChangeNotifier {
  int docLimit = 5;
  List<DocumentSnapshot> documents = [];
  DocumentSnapshot? lastDoc;
  bool isLoading = false;
  bool hasMore = true;

  // ============================================================================================//
  //                           Fetch Initial Batch of Data
  // ============================================================================================//

  void fetchInitialBatch(
      String searchByMachineSerial, String type, BuildContext context) async {
    if (searchByMachineSerial == "") {
      isLoading = true;
      notifyListeners();

      if (type == "outFloor") {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Transfer")
            .where("outFloor",
                isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
                        listen: false)
                    .currentUserFloor)
            .orderBy("date", descending: true)
            .limit(docLimit)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          lastDoc = querySnapshot.docs.last;
          notifyListeners();
        }

        documents = querySnapshot.docs;
        isLoading = false;
        hasMore = querySnapshot.docs.length == docLimit;
        notifyListeners();
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Transfer")
            .where("allocatedFloor",
                isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
                        listen: false)
                    .currentUserFloor)
            .orderBy("date", descending: true)
            .limit(docLimit)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          lastDoc = querySnapshot.docs.last;
          notifyListeners();
        }

        documents = querySnapshot.docs;
        isLoading = false;
        hasMore = querySnapshot.docs.length == docLimit;
        notifyListeners();
      }
    } else {
      if (type == "outFloor") {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Transfer")
            .where("outFloor",
                isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
                        listen: false)
                    .currentUserFloor)
            .where("machineSerial", isEqualTo: searchByMachineSerial)
            .get();

        documents = querySnapshot.docs;
        notifyListeners();
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Transfer")
            .where("allocatedFloor",
                isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
                        listen: false)
                    .currentUserFloor)
            .where("machineSerial", isEqualTo: searchByMachineSerial)
            .orderBy("date", descending: true)
            .get();

        documents = querySnapshot.docs;
        notifyListeners();
      }
    }
  }

  // ============================================================================================//
  //                           Fetch Next Batch of Data
  // ============================================================================================//
  void fetchNextBatch(
      String searchByMachineSerial, String type, BuildContext context) async {
    if (!hasMore || isLoading) return;

    isLoading = true;
    notifyListeners();

    if (searchByMachineSerial == "") {
      if (type == "outFloor") {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Transfer")
            .where("outFloor",
                isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
                        listen: false)
                    .currentUserFloor)
            .orderBy("date", descending: true)
            .startAfterDocument(lastDoc!)
            .limit(docLimit)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          lastDoc = querySnapshot.docs.last;
          notifyListeners();
        }

        documents.addAll(querySnapshot.docs);
        isLoading = false;
        hasMore = querySnapshot.docs.length == docLimit;
        notifyListeners();
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Transfer")
            .where("allocatedFloor",
                isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
                        listen: false)
                    .currentUserFloor)
            .orderBy("date", descending: true)
            .startAfterDocument(lastDoc!)
            .limit(docLimit)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          lastDoc = querySnapshot.docs.last;
          notifyListeners();
        }

        documents.addAll(querySnapshot.docs);
        isLoading = false;
        hasMore = querySnapshot.docs.length == docLimit;
        notifyListeners();
      }
    } else {
      if (type == "outFloor") {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Transfer")
            .where("outFloor",
                isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
                        listen: false)
                    .currentUserFloor)
            .where("machineSerial", isEqualTo: searchByMachineSerial)
            .orderBy("date", descending: true)
            .startAfterDocument(lastDoc!)
            .limit(docLimit)
            .get();

        documents.addAll(querySnapshot.docs);
        notifyListeners();
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Transfer")
            .where("allocatedFloor",
                isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
                        listen: false)
                    .currentUserFloor)
            .where("machineSerial", isEqualTo: searchByMachineSerial)
            .orderBy("date", descending: true)
            .startAfterDocument(lastDoc!)
            .limit(docLimit)
            .get();

        documents.addAll(querySnapshot.docs);
        notifyListeners();
      }
    }
  }
}
