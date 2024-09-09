import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/edit_machine_provider.dart';
import 'package:provider/provider.dart';

class MachineNameDropDownEdit extends StatelessWidget {
  String selectedMachineName;
  MachineNameDropDownEdit({Key? key, required this.selectedMachineName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: selectedMachineName,
      width: MediaQuery.of(context).size.width * 0.50,
      menuHeight: 200,
      onSelected: (value) {
        Provider.of<EditMachineDetailsProvider>(context, listen: false)
            .changeMachineName(value);

        print(Provider.of<EditMachineDetailsProvider>(context).editMachineName);
      },
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
                    .machineNameEdit!
                    .length;
            i++)
          DropdownMenuEntry(
            value: Provider.of<DataFetchFirebaseProvider>(context)
                .machineNameEdit![i],
            label: Provider.of<DataFetchFirebaseProvider>(context)
                .machineNameEdit![i],
          )
      ],
    );
  }
}
