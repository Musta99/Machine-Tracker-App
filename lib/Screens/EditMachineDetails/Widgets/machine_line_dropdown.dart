import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/edit_machine_provider.dart';
import 'package:provider/provider.dart';

class MachineLineDropDownEdit extends StatelessWidget {
  String line;
  MachineLineDropDownEdit({
    Key? key,
    required this.line,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width * 0.50,
      menuHeight: 200,
      hintText: line,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      onSelected: (value) {
        Provider.of<EditMachineDetailsProvider>(context, listen: false)
            .changeLine(value);
        print(Provider.of<EditMachineDetailsProvider>(context, listen: false)
            .shiftedLine);
      },
      dropdownMenuEntries: [
        for (int i = 0;
            i < Provider.of<DataFetchFirebaseProvider>(context).lineTo!.length;
            i++)
          DropdownMenuEntry(
            value: Provider.of<DataFetchFirebaseProvider>(context).lineTo![i],
            label: Provider.of<DataFetchFirebaseProvider>(context).lineTo![i],
          )
      ],
    );
  }
}
