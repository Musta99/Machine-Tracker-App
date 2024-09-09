import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Common_Widgets/common_button.dart';
import 'package:machine_tracker_app/MachineModel/machine_model.dart';
import 'package:machine_tracker_app/Providers/add_machine_details_provider.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/edit_machine_provider.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_allocated_floor.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_allocated_line.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_factory.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_machine_brand.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_machine_model.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_machine_name.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_status.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_type.dart';
import 'package:machine_tracker_app/Screens/EditMachineDetails/Widgets/machine_brand_dropdown_edit.dart';
import 'package:machine_tracker_app/Screens/EditMachineDetails/Widgets/machine_line_dropdown.dart';
import 'package:machine_tracker_app/Screens/EditMachineDetails/Widgets/machine_model_dropdown_edit.dart';
import 'package:machine_tracker_app/Screens/EditMachineDetails/Widgets/machine_name_dropdown.dart';
import 'package:machine_tracker_app/Screens/EditMachineDetails/Widgets/machine_shifted_to_dropdown.dart';
import 'package:machine_tracker_app/Screens/EditMachineDetails/Widgets/machine_type_dropdown.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/view_machine_status.dart';
import 'package:machine_tracker_app/Screens/bottom_nav_bar.dart';
import 'package:machine_tracker_app/constants.dart';
import 'package:provider/provider.dart';

class EditMachineDetailsScreen extends StatefulWidget {
  String factoryName;
  String machineName;
  String machineModel;
  final String machineBrand;
  final String machineType;
  final String machineNumber;
  String? machineFrom;
  String allocatedFloor;
  String allocatedLine;
  int machineOrder;
  String? note;

  EditMachineDetailsScreen({
    Key? key,
    required this.factoryName,
    required this.machineName,
    required this.machineModel,
    required this.machineBrand,
    required this.machineType,
    required this.machineNumber,
    this.machineFrom,
    required this.allocatedFloor,
    required this.allocatedLine,
    required this.machineOrder,
    this.note,
  }) : super(key: key);

  @override
  State<EditMachineDetailsScreen> createState() =>
      _EditMachineDetailsScreenState();
}

class _EditMachineDetailsScreenState extends State<EditMachineDetailsScreen> {
  TextEditingController updatedNoteController = TextEditingController();
  String title =
      "${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .fetchShiftedToFloor(context, widget.machineType);

    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .fetchShiftedLineTo(context, widget.machineType);
    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .fetchNameEdit(context, widget.machineType);
    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .fetchBrandEdit(context, widget.machineType);
    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .fetchModelEdit(
      widget.machineBrand,
      context,
      widget.machineType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Update Details of Machine"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              //==========================Factory Name============================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Factory: ",
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
                      title: Text(widget.factoryName),
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
                  MachineTypeDropDownEdit(
                    selectedType: widget.machineType,
                  ),
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
                  MachineNameDropDownEdit(
                      selectedMachineName: widget.machineName),
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
                  MachineBrandDropDownEdit(
                      brand: widget.machineBrand,
                      machineType: widget.machineType),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Model=================================
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
                  MachineModelDropDownEdit(model: widget.machineModel)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Number=================================
              TextFormField(
                // controller: numberController,
                initialValue: widget.machineNumber,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Machine Number",
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
              //
              //==================Machine Shifted From=================================
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
                      title: Text(widget.allocatedFloor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),

              //==================Machine Allocated Floor=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shifted To: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                    ),
                  ),
                  MachineShiftedToDropDownEdit(),
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
                  MachineLineDropDownEdit(
                    line: widget.allocatedLine,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              //==================Machine Order=================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Machine Order No: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          widget.machineOrder = int.parse(value);
                        });
                      },
                      initialValue: widget.machineOrder.toString(),
                      // controller: newMachineOrderController,
                      keyboardType: TextInputType.number,
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

              //==================Button=================================
              TextFormField(
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    widget.note = value;
                  });
                },
                initialValue: widget.note,
                decoration: InputDecoration(
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
                  if (Provider.of<EditMachineDetailsProvider>(context,
                          listen: false)
                      .shiftedToFloor
                      .isNotEmpty) {
                    ///========= Update in the Factory Collection====================================
                    ///=======================================
                    await FirebaseFirestore.instance
                        .collection(widget.factoryName)
                        .doc(widget.machineNumber)
                        .update({
                      "allocatedFloor": Provider.of<EditMachineDetailsProvider>(
                              context,
                              listen: false)
                          .shiftedToFloor,
                      "machineModel": Provider.of<EditMachineDetailsProvider>(
                                      context,
                                      listen: false)
                                  .editMachineModel ==
                              null
                          ? widget.machineModel
                          : Provider.of<EditMachineDetailsProvider>(context,
                                  listen: false)
                              .editMachineModel,
                      "machineName": Provider.of<EditMachineDetailsProvider>(
                                      context,
                                      listen: false)
                                  .editMachineName ==
                              null
                          ? widget.machineName
                          : Provider.of<EditMachineDetailsProvider>(context,
                                  listen: false)
                              .editMachineName,
                      "allocatedLine": Provider.of<EditMachineDetailsProvider>(
                                      context,
                                      listen: false)
                                  .shiftedLine ==
                              null
                          ? widget.allocatedLine
                          : Provider.of<EditMachineDetailsProvider>(context,
                                  listen: false)
                              .shiftedLine,
                      "machineOrder": widget.machineOrder,
                      "date": title,
                      "outFloor": widget.machineFrom,
                      "note": widget.note,
                    });

                    //  =======================================================================================
                    // ========= If Machine In-Out floors are same, don't save in Transfer history ========= //
                    //  =======================================================================================

                    if (widget.machineFrom !=
                        Provider.of<EditMachineDetailsProvider>(context,
                                listen: false)
                            .shiftedToFloor) {
                      ///========= Update in the Transfer Collection====================================//

                      await FirebaseFirestore.instance
                          .collection("Transfer")
                          .doc(widget.machineNumber)
                          .set(
                        {
                          "allocatedFloor":
                              Provider.of<EditMachineDetailsProvider>(context,
                                      listen: false)
                                  .shiftedToFloor,
                          "machineModel":
                              Provider.of<EditMachineDetailsProvider>(context,
                                              listen: false)
                                          .editMachineModel ==
                                      null
                                  ? widget.machineModel
                                  : Provider.of<EditMachineDetailsProvider>(
                                          context,
                                          listen: false)
                                      .editMachineModel,
                          "machineName":
                              Provider.of<EditMachineDetailsProvider>(context,
                                              listen: false)
                                          .editMachineName ==
                                      null
                                  ? widget.machineName
                                  : Provider.of<EditMachineDetailsProvider>(
                                          context,
                                          listen: false)
                                      .editMachineName,
                          "allocatedLine":
                              Provider.of<EditMachineDetailsProvider>(context,
                                              listen: false)
                                          .shiftedLine ==
                                      null
                                  ? widget.allocatedLine
                                  : Provider.of<EditMachineDetailsProvider>(
                                          context,
                                          listen: false)
                                      .shiftedLine,
                          "machineOrder": widget.machineOrder,
                          "date": title,
                          "machineSerial": widget.machineNumber,
                          "userName": Provider.of<DataFetchFirebaseProvider>(
                                  context,
                                  listen: false)
                              .currentUserName!,
                          "cardNo": Provider.of<DataFetchFirebaseProvider>(
                                  context,
                                  listen: false)
                              .currentUserCardNo!,
                          "factoryName": Provider.of<DataFetchFirebaseProvider>(
                                  context,
                                  listen: false)
                              .currentUserFactory,
                          "outFloor": widget.machineFrom,
                          "note": widget.note,
                        },
                        SetOptions(merge: true),
                      );

                      ///========= Update in the Transfer history Collection ==================================== //

                      await FirebaseFirestore.instance
                          .collection("TransferHistory: ${widget.factoryName}")
                          .doc(widget.machineNumber)
                          .set(
                        {
                          title: FieldValue.arrayUnion([
                            {
                              "Date": title,
                              "Allocated Floor":
                                  Provider.of<EditMachineDetailsProvider>(
                                          context,
                                          listen: false)
                                      .shiftedToFloor,
                              "Out Floor": widget.machineFrom,
                              "Model": Provider.of<EditMachineDetailsProvider>(
                                              context,
                                              listen: false)
                                          .editMachineModel ==
                                      null
                                  ? widget.machineModel
                                  : Provider.of<EditMachineDetailsProvider>(
                                          context,
                                          listen: false)
                                      .editMachineModel,
                              "Serial": widget.machineNumber,
                              "id": "Serial-1",
                              "Remarks": widget.note,
                            }
                          ])
                        },
                        SetOptions(merge: true),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "Successfully Updated",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );

                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please select Shifted To Floor",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )));
                  }
                },
                child: ButtonContainer(
                  title: "UPDATE",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
