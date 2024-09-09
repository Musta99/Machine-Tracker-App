import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:provider/provider.dart';

import '../../../Providers/add_machine_details_provider.dart';

class MachineAllocatedLineDropDown extends StatelessWidget {
  const MachineAllocatedLineDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width * 0.50,
      menuHeight: 200,
      hintText: "Allocated Line",
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      onSelected: (value) {
        Provider.of<AddMachineDetailsProvider>(context, listen: false)
            .selectLine(value);

        print(Provider.of<AddMachineDetailsProvider>(context,listen: false).machineAllocatedLine);
      },
      dropdownMenuEntries: [
        for (int i = 0;
            i < Provider.of<DataFetchFirebaseProvider>(context).line!.length;
            i++)
          DropdownMenuEntry(
            value: Provider.of<DataFetchFirebaseProvider>(context).line![i],
            label: Provider.of<DataFetchFirebaseProvider>(context).line![i],
          )
      ],
    );
  }
}
