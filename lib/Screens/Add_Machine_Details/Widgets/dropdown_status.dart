import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/add_machine_details_provider.dart';

class MachineStatusDropDown extends StatelessWidget {
  const MachineStatusDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      onSelected: (value) {
        Provider.of<AddMachineDetailsProvider>(context, listen: false)
            .selectStatus(value!);
        print(
          Provider.of<AddMachineDetailsProvider>(context, listen: false)
              .machineStatus,
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
      hintText: "Status",
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: "In-Use",
          label: "In-Use",
        ),
        DropdownMenuEntry(
          value: "Idle",
          label: "Idle",
        ),
      ],
    );
  }
}
