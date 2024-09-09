import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/edit_machine_provider.dart';
import 'package:provider/provider.dart';

import '../../../Providers/data_fetch_firebase_provider.dart';

class MachineShiftedToDropDownEdit extends StatelessWidget {
  const MachineShiftedToDropDownEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: "In Floor",
      width: MediaQuery.of(context).size.width * 0.50,
      menuHeight: 200,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      onSelected: (value) {
        Provider.of<EditMachineDetailsProvider>(context, listen: false)
            .shiftedTo(value);
        print(Provider.of<EditMachineDetailsProvider>(context, listen: false)
            .shiftedToFloor);
      },
      dropdownMenuEntries: [
        for (int i = 0;
            i < Provider.of<DataFetchFirebaseProvider>(context).floorTo!.length;
            i++)
          DropdownMenuEntry(
            value: Provider.of<DataFetchFirebaseProvider>(context).floorTo![i],
            label: Provider.of<DataFetchFirebaseProvider>(context).floorTo![i],
          )
      ],
    );
  }
}
