import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Common_Widgets/common_button.dart';
import 'package:machine_tracker_app/MachineModel/machine_model.dart';
import 'package:machine_tracker_app/Providers/add_machine_details_provider.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_allocated_floor.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_allocated_line.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_factory.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_machine_brand.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_machine_model.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_machine_name.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_machine_shifted_from.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_status.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_type.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/view_machine_status.dart';
import 'package:machine_tracker_app/Screens/bottom_nav_bar.dart';
import 'package:machine_tracker_app/constants.dart';
import 'package:provider/provider.dart';

class AddMachineDetailsScreen extends StatefulWidget {
  const AddMachineDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AddMachineDetailsScreen> createState() =>
      _AddMachineDetailsScreenState();
}

class _AddMachineDetailsScreenState extends State<AddMachineDetailsScreen> {
  TextEditingController machineOrderController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String title =
      "${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .currentUserFactory!);

    print(Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .currentUserFloor!);

    print(Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .currentUserName!);
    print(Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .currentUserCardNo!);
  }

  @override
  void dispose() {
    machineOrderController.dispose();
    numberController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Add Details of Machine"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //==========================Date Pick============================
              ListTile(
                title: Text(title),
                shape: RoundedRectangleBorder(
                  side: BorderSide(),
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.calendar_month,
                  ),
                  onPressed: () async {
                    DateTime? SelectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2060),
                    );

                    if (SelectedDate != null) {
                      setState(() {
                        title =
                            "${SelectedDate.day.toString()}-${SelectedDate.month.toString()}-${SelectedDate.year.toString()}";
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //  ======================= User name ============================
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "User Name: ",
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //         color: fontColor,
              //       ),
              //     ),
              //     Expanded(
              //       child: ListTile(
              //         title: Text(
              //           Provider.of<DataFetchFirebaseProvider>(context)
              //               .currentUserName!,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           side: BorderSide(),
              //           borderRadius: BorderRadius.circular(
              //             15,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.015,
              // ),

              //==========================Factory Name============================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Select Factory: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff404040),
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      title: Text(
                          Provider.of<DataFetchFirebaseProvider>(context)
                              .currentUserFactory!),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Type=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Machine Type: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  MachineTypeDropDown(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),

              //==================Machine Name=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Machine: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  MachineNameDropDown(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Brand=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Machine Brand: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  MachineBrandDropDown(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Model=================================
              // TextFormField(
              //   controller: modelController,
              //   decoration: InputDecoration(
              //     hintText: "Machine Model",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(
              //         15,
              //       ),
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Machine Model: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  DropdownMachineModel()
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Number=================================
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                  hintText: "Machine Serial Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),

              //==================Machine Status=================================
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Machine Status: ",
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //         color: fontColor,
              //       ),
              //     ),
              //     MachineStatusDropDown(),
              //   ],
              // ),

              //==================Shifted From=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "From: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  MachineShiftedFromFloorDropDown(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Shifted To=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "To: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff404040),
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      title: Text(
                          Provider.of<DataFetchFirebaseProvider>(context)
                              .currentUserFloor!),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Allocated Line=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Allocated Line: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  MachineAllocatedLineDropDown(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Order=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Machine Order No: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: TextFormField(
                      controller: machineOrderController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),

              //==================Note=================================

              TextFormField(
                maxLines: 3,
                controller: noteController,
                decoration: InputDecoration(
                  hintText: "Note",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Button=================================
              GestureDetector(
                onTap: () async {
                  if (title == null ||
                      Provider.of<DataFetchFirebaseProvider>(context, listen: false)
                              .currentUserFactory ==
                          null ||
                      Provider.of<AddMachineDetailsProvider>(context, listen: false)
                              .machineName ==
                          null ||
                      Provider.of<AddMachineDetailsProvider>(context, listen: false)
                              .machineBrand ==
                          "" ||
                      Provider.of<AddMachineDetailsProvider>(context, listen: false)
                              .machineType ==
                          "" ||
                      Provider.of<DataFetchFirebaseProvider>(context, listen: false)
                              .currentUserFloor ==
                          null ||
                      Provider.of<AddMachineDetailsProvider>(context, listen: false)
                              .machineModel ==
                          null ||
                      numberController.text.isEmpty ||
                      machineOrderController.text.isEmpty ||
                      Provider.of<AddMachineDetailsProvider>(context,
                                  listen: false)
                              .machineAllocatedLine ==
                          null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Please Fill all the Fields"),
                      ),
                    );
                  } else {
                    MachineModel machineModel = MachineModel(
                      date: title,
                      machineName: Provider.of<AddMachineDetailsProvider>(
                              context,
                              listen: false)
                          .machineName!,
                      machineModel: Provider.of<AddMachineDetailsProvider>(
                              context,
                              listen: false)
                          .machineModel!,
                      machineType: Provider.of<AddMachineDetailsProvider>(
                              context,
                              listen: false)
                          .machineType,
                      machineBrand: Provider.of<AddMachineDetailsProvider>(
                              context,
                              listen: false)
                          .machineBrand,
                      machineSerial:
                          numberController.text.toString().toUpperCase(),
                      factoryName: Provider.of<DataFetchFirebaseProvider>(
                              context,
                              listen: false)
                          .currentUserFactory!,
                      allocatedFloor: Provider.of<DataFetchFirebaseProvider>(
                              context,
                              listen: false)
                          .currentUserFloor!,
                      outFloor: Provider.of<AddMachineDetailsProvider>(context,
                                      listen: false)
                                  .machineOutFloor ==
                              null
                          ? "null"
                          : Provider.of<AddMachineDetailsProvider>(context,
                                  listen: false)
                              .machineOutFloor,
                      allocatedLine: Provider.of<AddMachineDetailsProvider>(
                              context,
                              listen: false)
                          .machineAllocatedLine!,
                      machineOrder: int.parse(machineOrderController.text),
                      note: noteController.text,
                      userName: Provider.of<DataFetchFirebaseProvider>(context,
                              listen: false)
                          .currentUserName!,
                      cardNo: Provider.of<DataFetchFirebaseProvider>(context,
                              listen: false)
                          .currentUserCardNo!,
                    );

                    //====  Adding to Factory Collection ===========================================
                    //==============================================================================
                    // ********************* First Check If this document exists or not *************** //
                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection(Provider.of<DataFetchFirebaseProvider>(
                                context,
                                listen: false)
                            .currentUserFactory!)
                        .where("machineSerial",
                            isEqualTo:
                                numberController.text.toString().toUpperCase())
                        .get();

                    if (querySnapshot.docs.isEmpty) {
                      await FirebaseFirestore.instance
                          .collection(Provider.of<DataFetchFirebaseProvider>(
                                  context,
                                  listen: false)
                              .currentUserFactory!)
                          .doc(numberController.text.toUpperCase())
                          .set(
                            machineModel.toJson(),
                          );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "Successfully Added",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );

                      Future.delayed(Duration(seconds: 1), () {
                        // First it will pop until first route
                        Navigator.popUntil(context, (route) => route.isFirst);
                        // Then It'll be replaced by the Bottom Nav Bar page
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => BottomNavBar(),
                          ),
                        );
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "This Machine is already in ${querySnapshot.docs[0]["allocatedFloor"]}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                    }

                    //==== Transfer Collection ===========================================
                    //================================

                    // FirebaseFirestore.instance
                    //     .collection("Transfer")
                    //     .doc(
                    //       numberController.text.toUpperCase(),
                    //     )
                    //     .set(
                    //       machineModel.toJson(),
                    //     );

                  }
                },
                child: ButtonContainer(
                  title: "SUBMIT",
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
