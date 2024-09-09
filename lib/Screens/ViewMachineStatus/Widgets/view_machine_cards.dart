import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/view_machine_provider.dart';
import 'package:machine_tracker_app/Screens/EditMachineDetails/edit_machine_details.dart';
import 'package:machine_tracker_app/constants.dart';
import 'package:provider/provider.dart';

class MachineCard extends StatelessWidget {
  List<DocumentSnapshot> filteredPosts;
  int index;
  bool visible;
  MachineCard({
    Key? key,
    required this.filteredPosts,
    required this.index,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          boxShadow: [
            BoxShadow(
              color: fontColor.withOpacity(0.4),
              offset: Offset(2, 5),
              blurRadius: 4,
              spreadRadius: 0.5,
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Column(
          children: [
            //===================Machine Order Field=======================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Machine Order No: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["machineOrder"].toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            //===================Machine Name Field=======================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Machine Name: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["machineName"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            //===================Machine Model Field=======================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Machine Model: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["machineModel"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            //===================Machine Type Field=======================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Machine Type: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["machineType"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: filteredPosts[index]["machineType"] == "Sewing"
                        ? Color(0xff12D58E)
                        : Colors.red,
                  ),
                )
              ],
            ),

            //===================Machine Brand Field=======================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Machine Brand: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["machineBrand"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),

            //===================Machine Serial Field=======================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Machine Serial: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["machineSerial"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            //===================Factory Field=======================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Factory: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["factoryName"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),

            //===================Allocated Floor Field=======================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Allocated Floor: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["allocatedFloor"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            //===================Allocated Floor Field=======================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Allocated Line: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  filteredPosts[index]["allocatedLine"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            //=================== Remarks Field =======================

            Row(
              children: [
                Text(
                  "Remarks: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Text(
                    filteredPosts[index]['note'],
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            //=================Edit and Delete Button ==================
            Visibility(
              visible: visible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => EditMachineDetailsScreen(
                            factoryName: filteredPosts[index]["factoryName"],
                            machineName: filteredPosts[index]["machineName"],
                            machineModel: filteredPosts[index]["machineModel"],
                            machineBrand: filteredPosts[index]["machineBrand"],
                            machineNumber: filteredPosts[index]
                                ["machineSerial"],
                            machineType: filteredPosts[index]["machineType"],
                            machineFrom: filteredPosts[index]["allocatedFloor"],
                            allocatedFloor: filteredPosts[index]
                                ["allocatedFloor"],
                            allocatedLine: filteredPosts[index]
                                ["allocatedLine"],
                            machineOrder: filteredPosts[index]["machineOrder"],
                            note: filteredPosts[index]["note"],
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.edit),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      )),
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        CupertinoIcons.delete,
                                        size: 40,
                                      ),
                                      Text(
                                        "Do you want to delete this Item?",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueAccent),
                                            onPressed: () async {
                                              try {
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        filteredPosts[index]
                                                            ["factoryName"])
                                                    .doc(filteredPosts[index]
                                                        ["machineSerial"])
                                                    .delete();
                                                // ===================================================================
                                                //         Will save in Delete Collection for future purpose //
                                                // ===================================================================
                                                await FirebaseFirestore.instance
                                                    .collection("Deleted Items")
                                                    .doc(filteredPosts[index]
                                                        ["machineSerial"])
                                                    .set({
                                                  "Date":
                                                      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                                  "Factory":
                                                      filteredPosts[index]
                                                          ["factoryName"],
                                                  "Floor": filteredPosts[index]
                                                      ["allocatedFloor"],
                                                  "Name": filteredPosts[index]
                                                      ["machineName"],
                                                  "Model": filteredPosts[index]
                                                      ["machineModel"],
                                                  "Brand": filteredPosts[index]
                                                      ["machineBrand"],
                                                  "Serial": filteredPosts[index]
                                                      ["machineSerial"],
                                                  "Authorized Person": Provider
                                                          .of<DataFetchFirebaseProvider>(
                                                              context,
                                                              listen: false)
                                                      .currentUserName
                                                });
                                              } catch (err) {
                                                print(err.toString());
                                              }

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel"),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Icon(Icons.delete))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
