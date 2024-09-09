import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:provider/provider.dart';

import '../../../Providers/add_machine_details_provider.dart';

class MachineTypeDropDown extends StatelessWidget {
  const MachineTypeDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
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
      hintText: "Type",
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
