import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:provider/provider.dart';

import '../../../Providers/add_machine_details_provider.dart';

class MachineAllocatedFloorDropDown extends StatelessWidget {
  const MachineAllocatedFloorDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width * 0.50,
      menuHeight: 200,
      hintText: Provider.of<DataFetchFirebaseProvider>(context, listen: false)
          .currentUserFloor,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      onSelected: (value) {
        Provider.of<AddMachineDetailsProvider>(context, listen: false)
            .selectFloor(value);
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
