import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Common_Widgets/common_button.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/log_in_screen.dart';
import 'package:machine_tracker_app/Screens/ProfileScreen/Widgets/information_card.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DataFetchFirebaseProvider>(context, listen: false)
        .countMachinePerFloor(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFFC946),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Color(0xffFFC946),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.profile_circled,
                      color: Colors.white,
                      size: 80,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      Provider.of<DataFetchFirebaseProvider>(context)
                          .currentUserName!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InformationCard(
                        keyData: "Your Factory: ",
                        valueData:
                            Provider.of<DataFetchFirebaseProvider>(context)
                                .currentUserFactory!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InformationCard(
                        keyData: "Your Floor: ",
                        valueData:
                            Provider.of<DataFetchFirebaseProvider>(context)
                                .currentUserFloor!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InformationCard(
                        keyData: "Your Section: ",
                        valueData:
                            Provider.of<DataFetchFirebaseProvider>(context)
                                .currentUserSection!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InformationCard(
                        keyData: "Your Email: ",
                        valueData:
                            Provider.of<DataFetchFirebaseProvider>(context)
                                .currentUserEmail!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InformationCard(
                        keyData: "Your Card No: ",
                        valueData:
                            Provider.of<DataFetchFirebaseProvider>(context)
                                .currentUserCardNo!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InformationCard(
                        keyData: "Machines in your floor:",
                        valueData: Provider.of<DataFetchFirebaseProvider>(
                                context,
                                listen: false)
                            .machineCount
                            .toString(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.popUntil(context, (route) => route.isFirst);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Successfully Logged Out"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LogInScreen(),
                            ),
                          );
                        },
                        child: ButtonContainer(title: "Sign out"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
