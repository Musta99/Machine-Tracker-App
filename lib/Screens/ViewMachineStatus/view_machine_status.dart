import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/view_machine_provider.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/log_in_screen.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_allocated_line.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/add_machine_screen.dart';
import 'package:machine_tracker_app/Screens/EditMachineDetails/edit_machine_details.dart';
import 'package:machine_tracker_app/Screens/ProfileScreen/user_profile.dart';
import 'package:machine_tracker_app/Screens/Transfer_Machine_Screen/transfer_machine_details.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/Widgets/view_machine_cards.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/notes_screen.dart';
import 'package:machine_tracker_app/constants.dart';
import 'package:provider/provider.dart';

class ViewMachineStatus extends StatefulWidget {
  const ViewMachineStatus({Key? key}) : super(key: key);

  @override
  State<ViewMachineStatus> createState() => _ViewMachineStatusState();
}

class _ViewMachineStatusState extends State<ViewMachineStatus> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .fetchCurrentUserFloor(FirebaseAuth.instance.currentUser!.uid);
    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .lineFetchForViewMachineScreen();
    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .floorFetchForViewMachineScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFFC946),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => TransferMachineScreen(),
            ),
          );
        },
        child: Icon(
          Icons.transfer_within_a_station,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Machine Details"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.height * 0.015),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 800),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        NoteScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Image.asset(
                "assets/icons/sticky-notes.png",
                height: MediaQuery.of(context).size.height * 0.032,
                width: MediaQuery.of(context).size.height * 0.032,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownMenu(
                  onSelected: (value) {
                    Provider.of<ViewMachineDetailProvider>(context,
                            listen: false)
                        .selectFactory(value!);

                    print(Provider.of<ViewMachineDetailProvider>(context,
                            listen: false)
                        .selectedFactory);
                  },
                  hintText: "Factory",
                  width: MediaQuery.of(context).size.width * 0.32,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "TSL-1", label: "TSL-1"),
                    DropdownMenuEntry(value: "TSL-2", label: "TSL-2"),
                    DropdownMenuEntry(value: "TSL-3", label: "TSL-3"),
                  ],
                ),
                DropdownMenu(
                  menuHeight: 300,
                  onSelected: (value) {
                    Provider.of<ViewMachineDetailProvider>(context,
                            listen: false)
                        .selectFloor(value!);

                    print(Provider.of<ViewMachineDetailProvider>(context,
                            listen: false)
                        .selectedFloor);
                    Provider.of<ViewMachineDetailProvider>(context,
                            listen: false)
                        .fetchInitialBatch(context);
                    _scrollController.addListener(() {
                      if (_scrollController.position.pixels ==
                          _scrollController.position.maxScrollExtent) {
                        Provider.of<ViewMachineDetailProvider>(context,
                                listen: false)
                            .fetchNextBatch(context);
                      }
                    });
                  },
                  hintText: "Floor",
                  width: MediaQuery.of(context).size.width * 0.32,
                  dropdownMenuEntries: [
                    for (int i = 0;
                        i <
                            Provider.of<DataFetchFirebaseProvider>(context)
                                .viewMachineFloor
                                .length;
                        i++)
                      DropdownMenuEntry(
                        value: Provider.of<DataFetchFirebaseProvider>(context)
                            .viewMachineFloor[i],
                        label: Provider.of<DataFetchFirebaseProvider>(context)
                            .viewMachineFloor[i],
                      )
                  ],
                ),
                DropdownMenu(
                    menuHeight: 300,
                    onSelected: (value) async {
                      // =========== Select Line ============//
                      Provider.of<ViewMachineDetailProvider>(context,
                              listen: false)
                          .selectLine(value);

                      print(Provider.of<ViewMachineDetailProvider>(context,
                              listen: false)
                          .selectedLine);
                      // =========== Number of Machine Count per Line ============//
                      if (Provider.of<DataFetchFirebaseProvider>(context,
                                      listen: false)
                                  .currentUserFloor ==
                              "Stock" &&
                          Provider.of<ViewMachineDetailProvider>(context,
                                      listen: false)
                                  .selectedFloor ==
                              "Stock") {
                        await Provider.of<ViewMachineDetailProvider>(context,
                                listen: false)
                            .countMachines(context);
                        print(Provider.of<ViewMachineDetailProvider>(context,
                                listen: false)
                            .numberOfMachines);
                      }

                      // =========== Fetching Data from Firestore ============//

                      Provider.of<ViewMachineDetailProvider>(context,
                              listen: false)
                          .fetchInitialBatch(context);
                      _scrollController.addListener(() {
                        if (_scrollController.position.pixels ==
                            _scrollController.position.maxScrollExtent) {
                          Provider.of<ViewMachineDetailProvider>(context,
                                  listen: false)
                              .fetchNextBatch(context);
                        }
                      });
                    },
                    hintText: "Line",
                    width: MediaQuery.of(context).size.width * 0.32,
                    dropdownMenuEntries: [
                      for (int i = 0;
                          i <
                              Provider.of<DataFetchFirebaseProvider>(context)
                                  .viewMachineLine
                                  .length;
                          i++)
                        DropdownMenuEntry(
                          value: Provider.of<DataFetchFirebaseProvider>(context)
                              .viewMachineLine[i],
                          label: Provider.of<DataFetchFirebaseProvider>(context)
                              .viewMachineLine[i],
                        )
                    ]),
              ],
            ),
            Provider.of<ViewMachineDetailProvider>(context).selectedFactory ==
                    null
                ? Expanded(
                    child: Center(
                      child: Text("Select a Factory and Floor"),
                    ),
                  )
                :

                //===================================================================
                // ====================Condition of Line Selection & Floor Selection =====================
                // ==================================================================
                Expanded(
                    child: Column(
                      children: [
                        // ========= Visible the Machine Count A/C to User =========== //
                        Visibility(
                          visible:
                              Provider.of<DataFetchFirebaseProvider>(context)
                                          .currentUserFloor ==
                                      "Stock"
                                  ? true
                                  : false,
                          child: Text(
                            "Number of Machines: ${Provider.of<ViewMachineDetailProvider>(context).numberOfMachines.toString()}",
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                Provider.of<ViewMachineDetailProvider>(context)
                                        .documents
                                        .length +
                                    1,
                            itemBuilder: (context, index) {
                              if (index ==
                                  Provider.of<ViewMachineDetailProvider>(
                                          context)
                                      .documents
                                      .length) {
                                if (Provider.of<ViewMachineDetailProvider>(
                                        context)
                                    .isLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (!Provider.of<
                                        ViewMachineDetailProvider>(context)
                                    .hasMore) {
                                  return Center(
                                    child: Text("No more data to fetch!"),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              }
                              return MachineCard(
                                filteredPosts:
                                    Provider.of<ViewMachineDetailProvider>(
                                            context)
                                        .documents,
                                index: index,
                                visible: Provider.of<ViewMachineDetailProvider>(
                                                    context)
                                                .selectedFloor ==
                                            Provider.of<DataFetchFirebaseProvider>(
                                                    context)
                                                .currentUserFloor &&
                                        Provider.of<ViewMachineDetailProvider>(
                                                    context)
                                                .selectedFactory ==
                                            Provider.of<DataFetchFirebaseProvider>(
                                                    context)
                                                .currentUserFactory
                                    ? true
                                    : false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
// StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection(
//                             Provider.of<ViewMachineDetailProvider>(context)
//                                 .selectedFactory!)
//                         .orderBy("machineOrder")
//                         .snapshots(),
//                     builder: (context, snapshots) {
//                       if (snapshots.connectionState ==
//                           ConnectionState.waiting) {
//                         return Expanded(
//                           child: Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         );
//                       } else {
//                         if (snapshots.hasData) {
//                           String? selectedFloor =
//                               Provider.of<ViewMachineDetailProvider>(context)
//                                   .selectedFloor;
//                           String? selectedLine =
//                               Provider.of<ViewMachineDetailProvider>(context)
//                                   .selectedLine;
//                           List<DocumentSnapshot> filteredPosts =
//                               snapshots.data!.docs;

//                           if (selectedFloor != null) {
//                             filteredPosts = filteredPosts
//                                 .where((doc) =>
//                                     doc["allocatedFloor"] == selectedFloor)
//                                 .toList();
//                           }
//                           if (selectedLine != null) {
//                             filteredPosts = filteredPosts
//                                 .where((doc) =>
//                                     doc["allocatedLine"] == selectedLine)
//                                 .toList();
//                           }
//                           if (searchBySerial.isNotEmpty) {
//                             filteredPosts = filteredPosts
//                                 .where((doc) =>
//                                     doc["machineSerial"] == searchBySerial)
//                                 .toList();
//                           }
//                           if (searchByModel.isNotEmpty) {
//                             filteredPosts = filteredPosts
//                                 .where(
//                                   (doc) => doc["machineModel"]
//                                       .contains(searchByModel),
//                                 )
//                                 .toList();
//                           }
//                           return filteredPosts.isEmpty
//                               ? Expanded(
//                                   child: Center(
//                                     child: Text("No Such Data Available"),
//                                   ),
//                                 )
//                               : Expanded(
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         "Total Results ${filteredPosts.length}",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: ListView.builder(
//                                           itemCount: filteredPosts.length,
//                                           itemBuilder: (context, index) {
//                                             return MachineCard(
//                                                 filteredPosts: filteredPosts,
//                                                 index: index);
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                         } else {
//                           return Center(
//                             child: Text("No data to show"),
//                           );
//                         }
//                       }
//                     },
//                   )
