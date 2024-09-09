import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Common_Widgets/common_button.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/add_machine_screen.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/view_machine_status.dart';
import 'package:machine_tracker_app/Screens/bottom_nav_bar.dart';
import 'package:machine_tracker_app/UserModel/user_model.dart';
import 'package:machine_tracker_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoScreen extends StatefulWidget {
  PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController cardController = TextEditingController();

  String selectedFactory = "";
  String selectedFloor = "";
  String selectedSection = "";

  void saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var userEmail = await prefs.getString("userEmail");
    var userPassword = await prefs.getString("userPassword");

    UserModel userModel = UserModel(
      uid: FirebaseAuth.instance.currentUser!.uid,
      userName: nameController.text,
      cardNo: cardController.text,
      userEmail: userEmail!,
      factoryName: selectedFactory,
      floorName: selectedFloor,
      password: userPassword!,
      section: selectedSection,
    );
    if (nameController.text.isEmpty ||
        cardController.text.isEmpty ||
        selectedFactory == "" ||
        selectedFloor == "" ||
        selectedSection == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please Fill all the Fields",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      FirebaseFirestore.instance
          .collection("UserData")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userModel.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "User Saved Successfully",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      Navigator.popUntil(context, (route) => route.isFirst);

      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 800),
            pageBuilder: (context, animation, secondaryAnimation) =>
                BottomNavBar(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your Personal Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // ===============================================================================
                //                              Logo
                // ===============================================================================
                Container(
                  child: Image.asset("assets/icons/MT_logo.png"),
                ),

                // ===============================================================================
                //                              TextFields
                // ===============================================================================
                Container(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffe8e8e8),
                            hintText: "Your Full Name"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: cardController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffe8e8e8),
                            hintText: "Your Card Number"),
                      ),
                      SizedBox(
                        height: 15,
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
                          DropdownMenu(
                            onSelected: (value) {
                              setState(() {
                                selectedFactory = value!;
                              });
                              print(selectedFactory);
                            },
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.50,
                            hintText: "Factory",
                            dropdownMenuEntries: [
                              DropdownMenuEntry(
                                value: "TSL-1",
                                label: "TSL-1",
                              ),
                              DropdownMenuEntry(
                                value: "TSL-2",
                                label: "TSL-2",
                              ),
                              DropdownMenuEntry(
                                value: "TSL-3",
                                label: "TSL-3",
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //==========================Floor Name============================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Floor: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: fontColor,
                            ),
                          ),
                          DropdownMenu(
                            onSelected: (value) {
                              setState(() {
                                selectedFloor = value;
                              });
                              print(selectedFloor);
                            },
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            menuHeight: 300,
                            width: MediaQuery.of(context).size.width * 0.50,
                            hintText: "Floor",
                            dropdownMenuEntries: [
                              for (int i = 0;
                                  i <
                                      Provider.of<DataFetchFirebaseProvider>(
                                              context)
                                          .floorName!
                                          .length;
                                  i++)
                                DropdownMenuEntry(
                                  value: Provider.of<DataFetchFirebaseProvider>(
                                          context)
                                      .floorName![i],
                                  label: Provider.of<DataFetchFirebaseProvider>(
                                          context)
                                      .floorName![i],
                                )
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      //==========================Factory Name============================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Section: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: fontColor,
                            ),
                          ),
                          DropdownMenu(
                            onSelected: (value) {
                              setState(() {
                                selectedSection = value!;
                              });
                              print(selectedSection);
                            },
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.50,
                            hintText: "Section",
                            dropdownMenuEntries: [
                              DropdownMenuEntry(
                                value: "Sewing",
                                label: "Sewing",
                              ),
                              DropdownMenuEntry(
                                value: "Non-Sewing",
                                label: "Non-Sewing",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ===============================================================================
                //                              Button
                // ===============================================================================
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          saveUserData();
                        },
                        child: ButtonContainer(
                          title: "SUBMIT",
                        ),
                      ),
                    ],
                  ),
                ),
                // ===============================================================================
                //                               Image
                // ===============================================================================
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Developed by - TSL R&D Team",
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        "assets/images/Logo.jpg",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
