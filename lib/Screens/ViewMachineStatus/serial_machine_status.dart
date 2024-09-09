import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/textfields_value_provider.dart';
import 'package:machine_tracker_app/Providers/view_machine_provider.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/Widgets/view_machine_cards.dart';
import 'package:provider/provider.dart';

class SerialWiseMachineStatus extends StatefulWidget {
  const SerialWiseMachineStatus({Key? key}) : super(key: key);

  @override
  State<SerialWiseMachineStatus> createState() =>
      _SerialWiseMachineStatusState();
}

class _SerialWiseMachineStatusState extends State<SerialWiseMachineStatus> {
  // void fetchSerialWise() async {
  //   try {
  //     if (searchBySerial != "") {
  //       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //           .collection(
  //               Provider.of<DataFetchFirebaseProvider>(context, listen: false)
  //                   .currentUserFactory!)
  //           .where("allocatedFloor",
  //               isEqualTo: Provider.of<DataFetchFirebaseProvider>(context,
  //                       listen: false)
  //                   .currentUserFloor!)
  //           .where("machineSerial", isEqualTo: searchBySerial.toUpperCase())
  //           .get();

  //       setState(() {
  //         documents = querySnapshot.docs;
  //       });

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Serial-Wise Machine Details"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Factory: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      color: Color(0xffFFC946),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          Provider.of<DataFetchFirebaseProvider>(context)
                              .currentUserFactory!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Floor: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      color: Color(0xffFFC946),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          Provider.of<DataFetchFirebaseProvider>(context)
                              .currentUserFloor!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
              onChanged: (value) {
                Provider.of<TextFieldsValueProvider>(context, listen: false)
                    .typeMachineSerial(value.toUpperCase());

                // Provider.of<ViewMachineDetailProvider>(context, listen: false)
                //     .fetchSerialWise(context);
              },
              decoration: InputDecoration(
                hintText: "Machine Serial",
                border: OutlineInputBorder(),
              ),
            ),
            Provider.of<TextFieldsValueProvider>(context).searchBySerial == ""
                ? Expanded(
                    child: Center(
                      child: Text("Type Machine Serial"),
                    ),
                  )
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(Provider.of<DataFetchFirebaseProvider>(
                                context,
                                listen: false)
                            .currentUserFactory!)
                        .where("allocatedFloor",
                            isEqualTo: Provider.of<DataFetchFirebaseProvider>(
                                    context,
                                    listen: false)
                                .currentUserFloor!)
                        .where("machineSerial",
                            isEqualTo: Provider.of<TextFieldsValueProvider>(
                                    context,
                                    listen: false)
                                .searchBySerial)
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (snapshots.connectionState ==
                          ConnectionState.none) {
                        return Expanded(
                            child: Center(
                          child: Text("No Connection has been made"),
                        ));
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            // Provider.of<ViewMachineDetailProvider>(context)
                            //     .documents
                            //     .length,
                            itemBuilder: (context, index) {
                              return MachineCard(
                                filteredPosts: snapshots.data!.docs,
                                // Provider.of<ViewMachineDetailProvider>(context)
                                //     .documents,
                                index: index,
                                visible: true,
                              );
                            },
                          ),
                        );
                      }
                    },
                  )
          ],
        ),
      ),
    );
  }
}
