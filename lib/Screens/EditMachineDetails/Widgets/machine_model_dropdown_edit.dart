import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/edit_machine_provider.dart';
import 'package:provider/provider.dart';

class MachineModelDropDownEdit extends StatelessWidget {
  String model;
  MachineModelDropDownEdit({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width * 0.50,
      menuHeight: 200,
      hintText: model,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      onSelected: (value) {
        Provider.of<EditMachineDetailsProvider>(context, listen: false)
            .changeMachineModel(value);
      },
      dropdownMenuEntries: [
        for (int i = 0;
            i <
                Provider.of<DataFetchFirebaseProvider>(context)
                    .machineModelEdit!
                    .length;
            i++)
          DropdownMenuEntry(
            value: Provider.of<DataFetchFirebaseProvider>(context)
                .machineModelEdit![i],
            label: Provider.of<DataFetchFirebaseProvider>(context)
                .machineModelEdit![i],
          )
      ],
    );
  }
}
