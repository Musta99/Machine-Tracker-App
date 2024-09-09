import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/add_machine_screen.dart';
import 'package:machine_tracker_app/Screens/ProfileScreen/user_profile.dart';
import 'package:machine_tracker_app/Screens/Transfer_Machine_Screen/transfer_machine_details.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/model_machine_status.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/serial_machine_status.dart';

import 'package:machine_tracker_app/Screens/ViewMachineStatus/view_machine_status.dart';
import 'package:machine_tracker_app/Screens/landing_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int activeIndex = 0;
  List bodyWidets = [
    ViewMachineStatus(),
    ModelWiseMachineStatus(),
    AddMachineDetailsScreen(),
    SerialWiseMachineStatus(),
    UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.blue,
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       CupertinoPageRoute(
        //         builder: (context) => AddMachineDetailsScreen(),
        //       ),
        //     );
        //   },
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(30),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.0123,
          ),
          height: MediaQuery.of(context).size.height * 0.0862,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 0;
                  });
                },
                child: BottomNavButtons(
                  iconLink: "assets/icons/home.png",
                  title: "Home",
                  color:
                      activeIndex == 0 ? Color(0xffFFC946) : Colors.transparent,
                  fontWeight: activeIndex == 0 ? FontWeight.bold : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 1;
                  });
                },
                child: BottomNavButtons(
                  iconLink: "assets/icons/model.png",
                  title: "Model",
                  color:
                      activeIndex == 1 ? Color(0xffFFC946) : Colors.transparent,
                  fontWeight: activeIndex == 1 ? FontWeight.bold : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 2;
                  });
                },
                child: BottomNavButtons(
                  iconLink: "assets/icons/add.png",
                  title: "Add",
                  color:
                      activeIndex == 2 ? Color(0xffFFC946) : Colors.transparent,
                  fontWeight: activeIndex == 2 ? FontWeight.bold : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 3;
                  });
                },
                child: BottomNavButtons(
                  iconLink: "assets/icons/serial.png",
                  title: "Serial",
                  color:
                      activeIndex == 3 ? Color(0xffFFC946) : Colors.transparent,
                  fontWeight: activeIndex == 3 ? FontWeight.bold : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = 4;
                  });
                },
                child: BottomNavButtons(
                  iconLink: "assets/icons/user.png",
                  title: "Profile",
                  color:
                      activeIndex == 4 ? Color(0xffFFC946) : Colors.transparent,
                  fontWeight: activeIndex == 4 ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),

        // AnimatedBottomNavigationBar(
        //   icons: [
        //     Icons.dashboard,
        //     Icons.transfer_within_a_station,

        //   ],
        //   activeColor: Colors.black,
        //   inactiveColor: Colors.grey,
        //   activeIndex: activeIndex,
        //   onTap: (index) {
        //     setState(() {
        //       activeIndex = index;
        //     });
        //   },
        //   gapLocation: GapLocation.center,
        //   notchSmoothness: NotchSmoothness.smoothEdge,
        //   leftCornerRadius: 32,
        //   rightCornerRadius: 32,
        // ),

        body: bodyWidets[activeIndex]);
  }
}

// ===================================================================
//          Bottom Nav Bar Buttons
// ===================================================================

class BottomNavButtons extends StatelessWidget {
  String iconLink;
  String title;
  Color? color;
  var fontWeight;

  BottomNavButtons({
    Key? key,
    required this.iconLink,
    required this.title,
    this.color,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.height * 0.0215,
          backgroundColor: color,
          child: Image.asset(
            iconLink,
            height: MediaQuery.of(context).size.height * 0.0277,
            width: MediaQuery.of(context).size.height * 0.0277,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
