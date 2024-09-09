import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Common_Widgets/common_button.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/log_in_screen.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/personal_info.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/add_machine_screen.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/view_machine_status.dart';
import 'package:machine_tracker_app/Screens/bottom_nav_bar.dart';
import 'package:machine_tracker_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();
  bool isLoading = false;

  void createUserAccount() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "userEmail",
      emailController.text.toString(),
    );
    await prefs.setString(
      "userPassword",
      passwordController.text.toString(),
    );
    try {
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          rePasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Please Fill all the fields",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else if (passwordController.text != rePasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Passwords don't match",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "User Created Successfully",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

        Future.delayed(
          Duration(seconds: 1),
          () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => PersonalInfoScreen(),
              ),
            );
          },
        );
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            err.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DataFetchFirebaseProvider>(context, listen: false).fetchFloor();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Already have an account?",
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
                                      LogInScreen(),
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
                              "LOG IN",
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
                        controller: emailController,
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
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffe8e8e8),
                            hintText: "Your Password"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: rePasswordController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xffe8e8e8),
                            hintText: "Re-enter your Password"),
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
                          createUserAccount();
                        },
                        child: ButtonContainer(
                          title: isLoading == true ? "SIGNING UP" : "SIGN UP",
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
