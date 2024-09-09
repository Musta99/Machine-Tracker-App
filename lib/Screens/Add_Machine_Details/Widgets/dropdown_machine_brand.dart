import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:provider/provider.dart';

import '../../../Providers/add_machine_details_provider.dart';

class MachineBrandDropDown extends StatelessWidget {
  const MachineBrandDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        width: MediaQuery.of(context).size.width * 0.50,
        menuHeight: 200,
        hintText: "Machine Brand",
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
        onSelected: (value) {
          Provider.of<AddMachineDetailsProvider>(context, listen: false)
              .selectBrand(value);
          print(Provider.of<AddMachineDetailsProvider>(context, listen: false)
              .machineBrand);

          if (Provider.of<AddMachineDetailsProvider>(context, listen: false)
                  .machineBrand ==
              "") {
            Provider.of<DataFetchFirebaseProvider>(context, listen: false)
                .machineModel;
          } else {
            Provider.of<DataFetchFirebaseProvider>(context, listen: false)
                .fetchModel(
                    Provider.of<AddMachineDetailsProvider>(context,
                            listen: false)
                        .machineBrand,
                    context);
          }
        },
        dropdownMenuEntries: [
          for (int i = 0;
              i <
                  Provider.of<DataFetchFirebaseProvider>(context)
                      .machineBrand!
                      .length;
              i++)
            DropdownMenuEntry(
              value: Provider.of<DataFetchFirebaseProvider>(context)
                  .machineBrand![i],
              label: Provider.of<DataFetchFirebaseProvider>(context)
                  .machineBrand![i],
            )
        ]);
  }
}
