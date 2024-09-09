import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/transfer_machine_provider.dart';
import 'package:machine_tracker_app/Screens/Transfer_Machine_Screen/transfer_history.dart';
import 'package:machine_tracker_app/Services/generatePdf.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class TransferMachineScreen extends StatefulWidget {
  const TransferMachineScreen({Key? key}) : super(key: key);

  @override
  State<TransferMachineScreen> createState() => _TransferMachineScreenState();
}

class _TransferMachineScreenState extends State<TransferMachineScreen> {
  String searchByMachineSerial = "";

  String type = "outFloor";

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<TransferMachineProvider>(context, listen: false)
        .fetchInitialBatch(searchByMachineSerial, type, context);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<TransferMachineProvider>(context, listen: false)
            .fetchNextBatch(searchByMachineSerial, type, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Machine In-Out Info"),
      ),
      body: Container(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff404040),
                        width: 0.8,
                      ),
                    ),
                    title: Text(Provider.of<DataFetchFirebaseProvider>(context)
                        .currentUserFactory!),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff404040),
                        width: 0.8,
                      ),
                    ),
                    title: Text(Provider.of<DataFetchFirebaseProvider>(context)
                        .currentUserFloor!),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                DropdownMenu(
                  initialSelection: type,
                  width: MediaQuery.of(context).size.width * 0.25,
                  onSelected: (value) {
                    setState(() {
                      type = value!;
                    });

                    Provider.of<TransferMachineProvider>(context, listen: false)
                        .fetchInitialBatch(
                            searchByMachineSerial, type, context);

                    _scrollController.addListener(() {
                      if (_scrollController.position.pixels ==
                          _scrollController.position.maxScrollExtent) {
                        Provider.of<TransferMachineProvider>(context,
                                listen: false)
                            .fetchNextBatch(
                                searchByMachineSerial, type, context);
                      }
                    });

                    print(value);
                  },
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "allocatedFloor", label: "In"),
                    DropdownMenuEntry(value: "outFloor", label: "Out"),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  searchByMachineSerial = value;
                });
                Provider.of<TransferMachineProvider>(context, listen: false)
                    .fetchInitialBatch(searchByMachineSerial, type, context);

                _scrollController.addListener(() {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                    Provider.of<TransferMachineProvider>(context, listen: false)
                        .fetchNextBatch(searchByMachineSerial, type, context);
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "Search by Machine Serial",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: Provider.of<TransferMachineProvider>(context)
                          .documents
                          .length +
                      1,
                  itemBuilder: (context, index) {
                    if (index ==
                        Provider.of<TransferMachineProvider>(context)
                            .documents
                            .length) {
                      if (Provider.of<TransferMachineProvider>(context)
                          .isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (!Provider.of<TransferMachineProvider>(context)
                          .hasMore) {
                        return Center(child: Text("No More Data to show"));
                      } else {
                        return SizedBox.shrink();
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                  "Date : ${Provider.of<TransferMachineProvider>(context).documents[index]["date"]}"),
                              Row(
                                children: [
                                  Text(
                                    "Model :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Card(
                                    color: Color(0xff93c9f6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(Provider.of<
                                              TransferMachineProvider>(context)
                                          .documents[index]["machineModel"]),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Serial :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Card(
                                    color: Color(0xff93c9f6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(Provider.of<
                                              TransferMachineProvider>(context)
                                          .documents[index]["machineSerial"]),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "In Floor :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Card(
                                        color: Color(0xffa1e3a4),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Provider.of<TransferMachineProvider>(
                                                        context)
                                                    .documents[index]
                                                ["allocatedFloor"],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Out Floor :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Card(
                                        color: Color(0xfff09999),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Provider.of<TransferMachineProvider>(
                                                    context)
                                                .documents[index]["outFloor"],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                  "Shifted By : ${Provider.of<TransferMachineProvider>(context).documents[index]["userName"]}"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => TransferHistory(
                                        machineSerial: Provider.of<
                                                    TransferMachineProvider>(
                                                context)
                                            .documents[index]["machineSerial"],
                                        factoryName: Provider.of<
                                                    TransferMachineProvider>(
                                                context)
                                            .documents[index]["factoryName"],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      )),
    );
  }
}

// ================================================================================ //
//
//
// Expanded(
//             child: FirestorePagination(
//                 limit: 10,
//                 viewType: ViewType.list,
//                 query: FirebaseFirestore.instance
//                     .collection("Transfer")
//                     .orderBy("date", descending: true),
//                 itemBuilder: (context, snapshots, index) {
//                   if (Provider.of<DataFetchFirebaseProvider>(context,
//                                   listen: false)
//                               .currentUserFactory !=
//                           null &&
//                       snapshots["factoryName"] !=
//                           Provider.of<DataFetchFirebaseProvider>(context,
//                                   listen: false)
//                               .currentUserFactory!) {
//                     return SizedBox.shrink();
//                   }
//                   if (Provider.of<DataFetchFirebaseProvider>(context,
//                                   listen: false)
//                               .currentUserFloor !=
//                           null &&
//                       snapshots[type] !=
//                           Provider.of<DataFetchFirebaseProvider>(context,
//                                   listen: false)
//                               .currentUserFloor!) {
//                     return SizedBox.shrink();
//                   }
//                   if (searchByMachineSerial.isNotEmpty &&
//                       snapshots["machineSerial"] != searchByMachineSerial) {
//                     return SizedBox.shrink();
//                   }

//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           children: [
//                             Text("Date : ${snapshots["date"]}"),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Model :",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Card(
//                                   color: Color(0xff93c9f6),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(snapshots["machineModel"]),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Serial :",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Card(
//                                   color: Color(0xff93c9f6),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(snapshots["machineSerial"]),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "In Floor :",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Card(
//                                       color: Color(0xffa1e3a4),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           snapshots["allocatedFloor"],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Out Floor :",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Card(
//                                       color: Color(0xfff09999),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           snapshots["outFloor"],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Text("Shifted By : ${snapshots["userName"]}"),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   CupertinoPageRoute(
//                                     builder: (context) => TransferHistory(
//                                       machineSerial: snapshots["machineSerial"],
//                                       factoryName: snapshots["factoryName"],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 "Details",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           )
