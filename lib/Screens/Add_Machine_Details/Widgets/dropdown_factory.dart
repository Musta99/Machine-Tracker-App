import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/add_machine_details_provider.dart';

class FactoryNameDropDown extends StatelessWidget {
  const FactoryNameDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      onSelected: (value) {
        Provider.of<AddMachineDetailsProvider>(context, listen: false)
            .selectFectory(value!);
        print(
          Provider.of<AddMachineDetailsProvider>(context, listen: false)
              .factoryName,
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
      hintText: "Factory",
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: "TSL-1",
          label: "TSL-1",
        ),
        DropdownMenuEntry(
          value: "TSL-2",
          label: "TSL-2",
        ),
        DropdownMenuEntry(
          value: "TSL-3",
          label: "TSL-3",
        ),
      ],
    );
  }
}
