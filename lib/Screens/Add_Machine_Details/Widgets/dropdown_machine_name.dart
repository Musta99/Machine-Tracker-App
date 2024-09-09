import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:provider/provider.dart';

import '../../../Providers/add_machine_details_provider.dart';

class MachineNameDropDown extends StatelessWidget {
  const MachineNameDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      onSelected: (value) {
        Provider.of<AddMachineDetailsProvider>(context,listen: false).selectMachine(value);
        print(Provider.of<AddMachineDetailsProvider>(context,listen: false).machineName);
      },
        width: MediaQuery.of(context).size.width * 0.50,
        menuHeight: 200,
        hintText: "Machine Name",
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
        dropdownMenuEntries: [
          for (int i = 0;
              i <
                  Provider.of<DataFetchFirebaseProvider>(context)
                      .machineName!
                      .length;
              i++)
            DropdownMenuEntry(
              value: Provider.of<DataFetchFirebaseProvider>(context)
                  .machineName![i],
              label: Provider.of<DataFetchFirebaseProvider>(context)
                  .machineName![i],
            )
        ]);
  }
}

// List<DropdownMenuEntry> sewingType = [
//   DropdownMenuEntry(
//     value: "Single Needle",
//     label: "Single Needle",
//   ),
//   DropdownMenuEntry(
//     value: "Two Needle",
//     label: "Two Needle",
//   ),
//   DropdownMenuEntry(
//     value: "S/N Top & Bottom Feed",
//     label: "S/N Top & Bottom Feed",
//   ),
//   DropdownMenuEntry(
//     value: "UNISON FEED (BL)",
//     label: "UNISON FEED (BL)",
//   ),
//   DropdownMenuEntry(
//     value: "OverLock Machine",
//     label: "OverLock Machine",
//   ),
//   DropdownMenuEntry(
//     value: "Inter Lock Machine",
//     label: "Inter Lock Machine",
//   ),
//   DropdownMenuEntry(
//     value: "BarTeck",
//     label: "BarTeck",
//   ),
//   DropdownMenuEntry(
//     value: "Cuff's Machine",
//     label: "Cuff's Machine",
//   ),
//   DropdownMenuEntry(
//     value: "Cycle Machine",
//     label: "Cycle Machine",
//   ),
//   DropdownMenuEntry(
//     value: "Knife Cutting",
//     label: "Knife Cutting",
//   ),
//   DropdownMenuEntry(
//     value: "Pattern Tacker",
//     label: "Pattern Tacker",
//   ),
//   DropdownMenuEntry(
//     value: "Pattern Forma",
//     label: "Pattern Forma",
//   ),
//   DropdownMenuEntry(
//     value: "Top Center",
//     label: "Top Center",
//   ),
//   DropdownMenuEntry(
//     value: "Button Hole",
//     label: "Button Hole",
//   ),
//   DropdownMenuEntry(
//     value: "Button Attach",
//     label: "Button Attach",
//   ),
//   DropdownMenuEntry(
//     value: "Zig-Zug Machine",
//     label: "Zig-Zug Machine",
//   ),
//   DropdownMenuEntry(
//     value: "Eyelet Hole",
//     label: "Eyelet Hole",
//   ),
//   DropdownMenuEntry(
//     value: "1Ndl Hi-Post Bed Machine",
//     label: "1Ndl Hi-Post Bed Machine",
//   ),
//   DropdownMenuEntry(
//     value: "2Ndl Hi-Post Bed Machine",
//     label: "2Ndl Hi-Post Bed Machine",
//   ),
//   DropdownMenuEntry(
//     value: "2Ndl Feed of the Arm Machine",
//     label: "2Ndl Feed of the Arm Machine",
//   ),
//   DropdownMenuEntry(
//     value: "3Ndl Feed of the Arm Machine",
//     label: "3Ndl Feed of the Arm Machine",
//   ),
//   DropdownMenuEntry(
//     value: "Saddle STC M/C",
//     label: "Saddle STC M/C",
//   ),
//   DropdownMenuEntry(
//     value: "Blind STC M/C",
//     label: "Blind STC M/C",
//   ),
//   DropdownMenuEntry(
//     value: "Flat Lock M/C -5 thread",
//     label: "Flat Lock M/C -5 thread",
//   ),
//   DropdownMenuEntry(
//     value: "Flat Lock M/C -6 thread",
//     label: "Flat Lock M/C -6 thread",
//   ),
//   DropdownMenuEntry(
//     value: "Linking M/C",
//     label: "Linking M/C",
//   ),
//   DropdownMenuEntry(
//     value: "Zig-Zag M/C",
//     label: "Zig-Zag M/C",
//   ),
//   DropdownMenuEntry(
//     value: "Pattern Sewing M/C",
//     label: "Pattern Sewing M/C",
//   ),
//   DropdownMenuEntry(
//     value: "Electric Pattern Sewing",
//     label: "Electric Pattern Sewing",
//   ),
//   DropdownMenuEntry(
//     value: "Cueves Stitch M/C",
//     label: "Cueves Stitch M/C",
//   ),
//   DropdownMenuEntry(
//     value: "Chain Stitch M/C",
//     label: "Chain Stitch M/C",
//   ),
//   DropdownMenuEntry(
//     value: "Pocket Setter APW",
//     label: "Pocket Setter APW",
//   ),
//   DropdownMenuEntry(
//     value: "3586 Grund M/C",
//     label: "3586 Grund M/C",
//   ),
// ];

// // ===================== Non-Sewing Type Machine =================
// // =========================================
// List<DropdownMenuEntry> nonSewingType = [
//   DropdownMenuEntry(
//     value: "Auto Bobbin Winder",
//     label: "Auto Bobbin Winder",
//   ),
//   DropdownMenuEntry(
//     value: "Iron Table",
//     label: "Iron Table",
//   ),
//   DropdownMenuEntry(
//     value: "Air Gun",
//     label: "Air Gun",
//   ),
//   DropdownMenuEntry(
//     value: "Air Snap Button",
//     label: "Air Snap Button",
//   ),
//   DropdownMenuEntry(
//     value: "Auto Down Filling",
//     label: "Auto Down Filling",
//   ),
//   DropdownMenuEntry(
//     value: "Down Filling",
//     label: "Down Filling",
//   ),
//   DropdownMenuEntry(
//     value: "Down Broken",
//     label: "Down Broken",
//   ),
//   DropdownMenuEntry(
//     value: "Hand Filling",
//     label: "Hand Filling",
//   ),
//   DropdownMenuEntry(
//     value: "Hot Punch",
//     label: "Hot Punch",
//   ),
//   DropdownMenuEntry(
//     value: "Joint Curves Press Welding",
//     label: "Joint Curves Press Welding",
//   ),
//   DropdownMenuEntry(
//     value: "Label Attach Stapler",
//     label: "Label Attach Stapler",
//   ),
//   DropdownMenuEntry(
//     value: "Loose Button",
//     label: "Loose Button",
//   ),
//   DropdownMenuEntry(
//     value: "Snap Button-Multi Head",
//     label: "Snap Button-Multi Head",
//   ),
//   DropdownMenuEntry(
//     value: "Mini Boiler Iron",
//     label: "Mini Boiler Iron",
//   ),
//   DropdownMenuEntry(
//     value: "Multi Head",
//     label: "Multi Head",
//   ),
//   DropdownMenuEntry(
//     value: "Portable Mini Boiler",
//     label: "Portable Mini Boiler",
//   ),
//   DropdownMenuEntry(
//     value: "Seam Sealing",
//     label: "Seam Sealing",
//   ),
//   DropdownMenuEntry(
//     value: "Smile Punch",
//     label: "Smile Punch",
//   ),
//   DropdownMenuEntry(
//     value: "Steam Generator",
//     label: "Steam Generator",
//   ),
//   DropdownMenuEntry(
//     value: "Stop Mark-Cross Seal",
//     label: "Stop Mark-Cross Seal",
//   ),
//   DropdownMenuEntry(
//     value: "Snap Button",
//     label: "Snap Button",
//   ),
//   DropdownMenuEntry(
//     value: "Snap Button Tester",
//     label: "Snap Button Tester",
//   ),
//   DropdownMenuEntry(
//     value: "Steam Iron",
//     label: "Steam Iron",
//   ),
//   DropdownMenuEntry(
//     value: "Thread Winder",
//     label: "Thread Winder",
//   ),
//   DropdownMenuEntry(
//     value: "Ultrasonin Label Attach",
//     label: "Ultrasonic Label Attach",
//   ),
//   DropdownMenuEntry(
//     value: "Vacuum Cleaner-Mini",
//     label: "Vacuum Cleaner-Mini",
//   ),
//   DropdownMenuEntry(
//     value: "Vacuum Cleaner-Big",
//     label: "Vacuum Cleaner-Big",
//   ),
//   DropdownMenuEntry(
//     value: "Vacuum Table",
//     label: "Vacuum Table",
//   ),
//   DropdownMenuEntry(
//     value: "Water Tester",
//     label: "Water Tester",
//   ),
//   DropdownMenuEntry(
//     value: "Weight Scale",
//     label: "Weight Scale",
//   ),
//   DropdownMenuEntry(
//     value: "Weight Scale-Digital",
//     label: "Weight Scale-Digital",
//   ),
//   DropdownMenuEntry(
//     value: "Wide Curve Press Welding",
//     label: "Wide Curve Press Welding",
//   ),
//   DropdownMenuEntry(
//     value: "3D Press Welding",
//     label: "3D Press Welding",
//   ),
// ];
