import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Providers/edit_machine_provider.dart';
import 'package:provider/provider.dart';

class MachineBrandDropDownEdit extends StatelessWidget {
  String machineType;
  String brand;
  MachineBrandDropDownEdit({
    Key? key,
    required this.brand,
    required this.machineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        width: MediaQuery.of(context).size.width * 0.50,
        menuHeight: 200,
        hintText: brand,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
        onSelected: (value) {
          Provider.of<EditMachineDetailsProvider>(context, listen: false)
              .changeMachineBrand(value);

          if (Provider.of<EditMachineDetailsProvider>(context, listen: false)
                  .editMachineBrand ==
              "") {
            Provider.of<DataFetchFirebaseProvider>(context, listen: false)
                .machineModelEdit;
          } else {
            Provider.of<DataFetchFirebaseProvider>(context, listen: false)
                .fetchModelEdit(
                    Provider.of<EditMachineDetailsProvider>(context,
                            listen: false)
                        .editMachineBrand!,
                    context,
                    machineType);
          }
        },
        dropdownMenuEntries: [
          for (int i = 0;
              i <
                  Provider.of<DataFetchFirebaseProvider>(context)
                      .machineBrandEdit!
                      .length;
              i++)
            DropdownMenuEntry(
              value: Provider.of<DataFetchFirebaseProvider>(context)
                  .machineBrandEdit![i],
              label: Provider.of<DataFetchFirebaseProvider>(context)
                  .machineBrandEdit![i],
            )
        ]);
  }
}
