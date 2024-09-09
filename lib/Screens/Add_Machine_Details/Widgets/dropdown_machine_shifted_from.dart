import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/Widgets/dropdown_allocated_floor.dart';
import 'package:provider/provider.dart';

import '../../../Providers/add_machine_details_provider.dart';

class MachineShiftedFromFloorDropDown extends StatelessWidget {
  const MachineShiftedFromFloorDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width * 0.50,
      menuHeight: 200,
      hintText: "Out Floor",
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      onSelected: (value) {
        Provider.of<AddMachineDetailsProvider>(context, listen: false)
            .selectOutFloor(value);
        print(Provider.of<AddMachineDetailsProvider>(context,listen: false).machineOutFloor);
      },
      dropdownMenuEntries: [
        for (int i = 0;
            i < Provider.of<DataFetchFirebaseProvider>(context).floor!.length;
            i++)
          DropdownMenuEntry(
            value: Provider.of<DataFetchFirebaseProvider>(context).floor![i],
            label: Provider.of<DataFetchFirebaseProvider>(context).floor![i],
          )
      ],
    );
  }
}
