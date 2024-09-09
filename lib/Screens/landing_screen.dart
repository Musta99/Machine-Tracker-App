import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_tracker_app/Common_Widgets/common_button.dart';
import 'package:machine_tracker_app/Providers/landing_screen_provider.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/sign_up_screen.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/add_machine_screen.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/view_machine_status.dart';
import 'package:machine_tracker_app/Screens/bottom_nav_bar.dart';
import 'package:machine_tracker_app/constants.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "TRACK & LOCATE",
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "YOUR MACHINES",
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          "FROM ANYWHERE",
                          textStyle: GoogleFonts.bodoniModa(
                            color: fontColor,
                            fontSize: 25,
                          ),
                        ),
                        FadeAnimatedText(
                          "FROM ANYTIME",
                          textStyle: GoogleFonts.bodoniModa(
                            color: fontColor,
                            fontSize: 25,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                      totalRepeatCount: 2,
                      pause: Duration(milliseconds: 1000),
                      onFinished: () {
                        Provider.of<LandingScreenProvider>(context,
                                listen: false)
                            .changeVisibility();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // ===============================================================================
            //                              Description and Button
            // ===============================================================================
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Machine tracking apps help you to monitor the location of machines, all in one convenient mobile interface.  This can improve efficiency, prevent downtime, and optimize maintenance schedules.",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible:
                        Provider.of<LandingScreenProvider>(context).isVisible ==
                                true
                            ? true
                            : false,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(
                              milliseconds: 700,
                            ),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SignUpScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: ButtonContainer(
                        title: "START",
                      ),
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
                  Image.asset(
                    "assets/images/s7300a.png",
                  ),
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
    );
  }
}
