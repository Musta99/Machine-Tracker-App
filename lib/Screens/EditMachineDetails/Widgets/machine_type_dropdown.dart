import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/add_machine_details_provider.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:provider/provider.dart';

class MachineTypeDropDownEdit extends StatelessWidget {
  String selectedType;
  MachineTypeDropDownEdit({
    Key? key,
    required this.selectedType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: selectedType,
      onSelected: (value) {
        // Select Machine Type //
        Provider.of<AddMachineDetailsProvider>(context, listen: false)
            .selectType(value!);

        // Fetch Machine Name //
        Provider.of<DataFetchFirebaseProvider>(context, listen: false)
            .fetchName(context);

        // Fetch Machine Brand //
        Provider.of<DataFetchFirebaseProvider>(context, listen: false)
            .fetchBrand(context);

        // Fetch Floor //
        Provider.of<DataFetchFirebaseProvider>(context, listen: false)
            .fetchAllocatedFloor(context);
        // Fetch Line //
        Provider.of<DataFetchFirebaseProvider>(context, listen: false)
            .fetchAllocatedLine(context);

        print(
          Provider.of<AddMachineDetailsProvider>(context, listen: false)
              .machineType,
        );
      },
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.50,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: "Sewing",
          label: "Sewing",
        ),
        DropdownMenuEntry(
          value: "Non-Sewing",
          label: "Non-Sewing",
        ),
      ],
    );
  }
}
