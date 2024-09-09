import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/add_machine_details_provider.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/edit_machine_provider.dart';
import 'package:machine_tracker_app/Providers/landing_screen_provider.dart';
import 'package:machine_tracker_app/Providers/textfields_value_provider.dart';
import 'package:machine_tracker_app/Providers/transfer_machine_provider.dart';
import 'package:machine_tracker_app/Providers/view_machine_provider.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/log_in_screen.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/personal_info.dart';
import 'package:machine_tracker_app/Screens/AccountCreationScreens/sign_up_screen.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/add_machine_screen.dart';
import 'package:machine_tracker_app/Screens/ProfileScreen/user_profile.dart';
import 'package:machine_tracker_app/Screens/ViewMachineStatus/view_machine_status.dart';
import 'package:machine_tracker_app/Screens/bottom_nav_bar.dart';
import 'package:machine_tracker_app/Screens/landing_screen.dart';
import 'package:machine_tracker_app/Screens/test_code.dart';
import 'package:machine_tracker_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddMachineDetailsProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => ViewMachineDetailProvider()),
        ChangeNotifierProvider(
            create: (context) => DataFetchFirebaseProvider()),
        ChangeNotifierProvider(
            create: (context) => EditMachineDetailsProvider()),
        ChangeNotifierProvider(create: (context) => TextFieldsValueProvider()),
        ChangeNotifierProvider(create: (context) => LandingScreenProvider()),
        ChangeNotifierProvider(create: (context) => TransferMachineProvider())
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser != null
              ? BottomNavBar()
              : LandingScreen(),
        );
      },
    );
  }
}
