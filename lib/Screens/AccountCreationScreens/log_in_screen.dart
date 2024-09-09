import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Common_Widgets/common_button.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/sign_up_screen.dart';
import 'package:machine_tracker_app/Screens/bottom_nav_bar.dart';
import 'package:machine_tracker_app/constants.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController logInEmailController = TextEditingController();

  TextEditingController logInPasswordController = TextEditingController();
  bool isLoading = false;

  void logInUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: logInEmailController.text,
          password: logInPasswordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Successfully Logged In"),
        ),
      );

      Navigator.popUntil(context, (route) => route.isFirst);

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) =>
              BottomNavBar(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            err.toString(),
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log in to your account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(
                                    milliseconds: 700,
                                  ),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
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
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Color(0xff5495FF),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                        controller: logInEmailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffe8e8e8),
                            hintText: "Your Email Address"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: logInPasswordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffe8e8e8),
                            hintText: "Your Password"),
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
                          // Navigator.pushReplacement(
                          //   context,
                          //   CupertinoPageRoute(
                          //     builder: (context) => PersonalInfoScreen(),
                          //   ),
                          // );
                          logInUser();
                        },
                        child: ButtonContainer(
                          title: isLoading == true ? "LOGGING IN..." : "LOG IN",
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
