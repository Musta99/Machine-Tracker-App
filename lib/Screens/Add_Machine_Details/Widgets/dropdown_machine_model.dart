import 'package:flutter/material.dart';
import 'package:machine_tracker_app/Providers/add_machine_details_provider.dart';
import 'package:machine_tracker_app/Providers/data_fetch_firebase_provider.dart';
import 'package:machine_tracker_app/Screens/Add_Machine_Details/add_machine_screen.dart';
import 'package:provider/provider.dart';

class DropdownMachineModel extends StatelessWidget {
  const DropdownMachineModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width * 0.50,
      menuHeight: 200,
      hintText: "Machine Model",
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
      onSelected: (value) {
        Provider.of<AddMachineDetailsProvider>(context, listen: false)
            .selectModel(value);
        print(Provider.of<AddMachineDetailsProvider>(context,listen: false).machineModel);
      },
      dropdownMenuEntries: [
        for (int i = 0;
            i <
                Provider.of<DataFetchFirebaseProvider>(context)
                    .machineModel!
                    .length;
            i++)
          DropdownMenuEntry(
            value: Provider.of<DataFetchFirebaseProvider>(context)
                .machineModel![i],
            label: Provider.of<DataFetchFirebaseProvider>(context)
                .machineModel![i],
          )
      ],
    );
  }
}

// List<DropdownMenuEntry> sunstar = [
//   DropdownMenuEntry(
//     value: "KM-250A-7S",
//     label: "KM-250A-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-250AU-7S",
//     label: "KM-250AU-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-2300 EMG",
//     label: "KM-2300 EMG",
//   ),
//   DropdownMenuEntry(
//     value: "KM-2300 UMG",
//     label: "KM-2300 UMG",
//   ),
//   DropdownMenuEntry(
//     value: "KM-1750 MG-7",
//     label: "KM-1750 MG-7",
//   ),
//   DropdownMenuEntry(
//     value: "KM-350A",
//     label: "KM-350A",
//   ),
//   DropdownMenuEntry(
//     value: "KM-350A-7S",
//     label: "KM-350A-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-350B-7S",
//     label: "KM-350B-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-1790 MG-7",
//     label: "KM-1790 MG-7",
//   ),
//   DropdownMenuEntry(
//     value: "KM-3500 MG",
//     label: "KM-3500 MG",
//   ),
//   DropdownMenuEntry(
//     value: "KM-530-7S",
//     label: "KM-530-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-506",
//     label: "KM-506",
//   ),
//   DropdownMenuEntry(
//     value: "KM-506-7S",
//     label: "KM-506-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-530",
//     label: "KM-530",
//   ),
//   DropdownMenuEntry(
//     value: "KM-530-7S",
//     label: "KM-530-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-380",
//     label: "KM-380",
//   ),
//   DropdownMenuEntry(
//     value: "KM-757",
//     label: "KM-757",
//   ),
//   DropdownMenuEntry(
//     value: "KM-757-7S",
//     label: "KM-757-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-797-7S",
//     label: "KM-797-7S",
//   ),
//   DropdownMenuEntry(
//     value: "KM-1750MG-7",
//     label: "KM-1750MG-7",
//   ),
//   DropdownMenuEntry(
//     value: "KM-1790MG-7",
//     label: "KM-1790MG-7",
//   ),
//   DropdownMenuEntry(
//     value: "KM-3420 BL",
//     label: "KM-3420 BL",
//   ),
//   DropdownMenuEntry(
//     value: "KM-1642 BL",
//     label: "KM-1640 BL",
//   ),
//   DropdownMenuEntry(
//     value: "SC-7300M",
//     label: "SC-7300M",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/A-B1201M",
//     label: "SPS/A-B1201M",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/R-3020H",
//     label: "SPS/R-3020H",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/A-1507-GS-10",
//     label: "SPS/A-1507-GS-10",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/A-1507-HS-20",
//     label: "SPS/A-1507-HS-20",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/A-B1201M",
//     label: "SPS/A-B1201M",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/C-B1201M",
//     label: "SPS/C-B1201M",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/C-B1201HWA",
//     label: "SPS/C-B1201HWA",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/D-B1201M",
//     label: "SPS/D-B1201M",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/B-1507-HJ-23",
//     label: "SPS/B-1507-HJ-23",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/B-2516-HS-20",
//     label: "SPS/B-2516-HS-20",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/F-2516",
//     label: "SPS/F-2516",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/F-2516-HS-20",
//     label: "SPS/F-2516-HS-20",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/D-BH-3000G",
//     label: "SPS/D-BH-3000G",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/D-B1202-02/03",
//     label: "SPS/D-B1202-02/03",
//   ),
//   DropdownMenuEntry(
//     value: "SC-8200",
//     label: "SC-8200",
//   ),
//   DropdownMenuEntry(
//     value: "SW-9280",
//     label: "SW-9280",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/B-BH1263",
//     label: "SPS/B-BH1263",
//   ),
//   DropdownMenuEntry(
//     value: "KM-2070",
//     label: "KM-2070",
//   ),
//   DropdownMenuEntry(
//     value: "SPS/D-BH-6000-01",
//     label: "SPS/D-BH-6000-01",
//   ),
//   DropdownMenuEntry(
//     value: "KM-827",
//     label: "KM-827",
//   ),
// ];

// /// ==== Brother Machine ==== ///

// List<DropdownMenuEntry> brother = [
//   DropdownMenuEntry(
//     value: "SC-7300A-633P",
//     label: "SC-7300A-633P",
//   ),
// ];

// /// ==== JUKI Machine ==== ///

// List<DropdownMenuEntry> juki = [
//   DropdownMenuEntry(
//     value: "DDL-8000A",
//     label: "DDL-8000A",
//   ),
//   DropdownMenuEntry(
//     value: "DDL-9000C",
//     label: "DDL-9000C",
//   ),
//   DropdownMenuEntry(
//     value: "DDL-9000B-MS",
//     label: "DDL-9000B-MS",
//   ),
//   DropdownMenuEntry(
//     value: "DLN-5410N-7",
//     label: "DLN-5410N-7",
//   ),
//   DropdownMenuEntry(
//     value: "DLN-5410NDD-7",
//     label: "DLN-5410NDD-7",
//   ),
//   DropdownMenuEntry(
//     value: "DLN-9010A-SS",
//     label: "DLN-9010A-SS",
//   ),
//   DropdownMenuEntry(
//     value: "DLU-5490N-7",
//     label: "DLU-5490N-7",
//   ),
//   DropdownMenuEntry(
//     value: "DMN-5420-7",
//     label: "DMN-5420-7",
//   ),
//   DropdownMenuEntry(
//     value: "DMN-5420N-7",
//     label: "DMN-5420N-7",
//   ),
//   DropdownMenuEntry(
//     value: "DMN-5420NDD-7",
//     label: "DMN-5420NDD-7",
//   ),
//   DropdownMenuEntry(
//     value: "DLM-5400NDD-7",
//     label: "DLM-5400NDD-7",
//   ),
//   DropdownMenuEntry(
//     value: "AMS-210ENS-1510",
//     label: "AMS-210ENS-1510",
//   ),
//   DropdownMenuEntry(
//     value: "AMS-221EN-3020HS",
//     label: "AMS-221EN-3020HS",
//   ),
//   DropdownMenuEntry(
//     value: "DSC-245-7",
//     label: "DSC-245-7",
//   ),
//   DropdownMenuEntry(
//     value: "LH-3568A-7",
//     label: "LH-3568A-7",
//   ),
//   DropdownMenuEntry(
//     value: "LH-3588A-7",
//     label: "LH-3588A-7",
//   ),
//   DropdownMenuEntry(
//     value: "LK-1900BN",
//     label: "LK-1900BN",
//   ),
//   DropdownMenuEntry(
//     value: "LK-1903BN",
//     label: "LK-1903BN",
//   ),
//   DropdownMenuEntry(
//     value: "LBH-1790AN",
//     label: "LBH-1790AN",
//   ),
//   DropdownMenuEntry(
//     value: "DU-1181N-7",
//     label: "DU-1181N-7",
//   ),
//   DropdownMenuEntry(
//     value: "JK-798-4-S/4",
//     label: "JK-798-4-S/4",
//   ),
//   DropdownMenuEntry(
//     value: "MH-380",
//     label: "MH-380",
//   ),
//   DropdownMenuEntry(
//     value: "MS-191",
//     label: "MS-191",
//   ),
//   DropdownMenuEntry(
//     value: "MS-1190",
//     label: "MS-1190",
//   ),
//   DropdownMenuEntry(
//     value: "MS-1261M",
//     label: "MS-1261M",
//   ),
//   DropdownMenuEntry(
//     value: "DLU-5498N-7",
//     label: "DLU-5498N-7",
//   ),
//   DropdownMenuEntry(
//     value: "PLC-2710-7",
//     label: "PLC-2710-7",
//   ),
//   DropdownMenuEntry(
//     value: "LH-896N",
//     label: "LH-896N",
//   ),
// ];

// /// ==== ZOJE Machine ==== ///

// List<DropdownMenuEntry> zoje = [
//   DropdownMenuEntry(
//     value: "ZJ-9903AR-D3B",
//     label: "ZJ-9903AR-D3B",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-5303AR-D2",
//     label: "ZJ-5303AR-D2",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-1970NF",
//     label: "ZJ-1970NF",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-5821A",
//     label: "ZJ-5821A",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-9827-D4",
//     label: "ZJ-9827-D4",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-5770A-1510HF1-C/HF1",
//     label: "ZJ-5770A-1510HF1-C/HF1",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-5770B-1510H-A",
//     label: "ZJ-5770B-1510H-A",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-5770A-3020HF1-C",
//     label: "ZJ-5770A-3020HF1-C",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-2842-BD",
//     label: "ZJ-2842-BD",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-2845-BD",
//     label: "ZJ-2845-BD",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-1900DHS-C-3/04",
//     label: "ZJ-1900DHS-C-3/04",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-1900DSS/DHS",
//     label: "ZJ-1900DSS/DHS",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-1900DHS-C",
//     label: "ZJ-1900DHS-C",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-1900DHS-C-/04",
//     label: "ZJ-1900DHS-C-/04",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-9701LAR",
//     label: "ZJ-9701LAR",
//   ),
// ];

// /// ==== UNICORN Machine ==== ///

// List<DropdownMenuEntry> unicorn = [
//   DropdownMenuEntry(
//     value: "LS2-H5200",
//     label: "LS2-H5200",
//   ),
//   DropdownMenuEntry(
//     value: "LS2-H5500",
//     label: "LS2-H5500",
//   ),
//   DropdownMenuEntry(
//     value: "H-580H",
//     label: "H-580H",
//   ),
//   DropdownMenuEntry(
//     value: "DT6-H893",
//     label: "DT6-H893",
//   ),
//   DropdownMenuEntry(
//     value: "LT5-H7200-1",
//     label: "LT5-H7200-1",
//   ),
//   DropdownMenuEntry(
//     value: "PLN-27B",
//     label: "PLN-27B",
//   ),
//   DropdownMenuEntry(
//     value: "EXT-8514",
//     label: "EXT-8514",
//   ),
// ];

// /// ==== PFAF Machine ==== ///

// List<DropdownMenuEntry> pfaf = [
//   DropdownMenuEntry(
//     value: "3586-22/02",
//     label: "3586-22/02",
//   ),
// ];

// /// ==== BEDOLY Machine ==== ///

// List<DropdownMenuEntry> bedoly = [
//   DropdownMenuEntry(
//     value: "BDL-B5490B-7-DT",
//     label: "BDL-B5490B-7-DT",
//   ),
//   DropdownMenuEntry(
//     value: "BDL-B5493C-7",
//     label: "BDL-B5493C-7",
//   ),
// ];

// /// ==== PEGASUS Machine ==== ///

// List<DropdownMenuEntry> pegasus = [
//   DropdownMenuEntry(
//     value: "EXT-5214-M03",
//     label: "EXT-5214-M03",
//   ),
//   DropdownMenuEntry(
//     value: "EXT-5214-84",
//     label: "EXT-5214-84",
//   ),
//   DropdownMenuEntry(
//     value: "M-752-13H",
//     label: "M-752-13H",
//   ),
//   DropdownMenuEntry(
//     value: "EXT-8514-14",
//     label: "EXT-8514-14",
//   ),
//   DropdownMenuEntry(
//     value: "EXT-8214-84",
//     label: "EXT-8214-84",
//   ),
//   DropdownMenuEntry(
//     value: "798-T-4-51-M03",
//     label: "798-T-4-51-M03",
//   ),
// ];

// /// ==== LOIVA Machine ==== ///

// List<DropdownMenuEntry> loiva = [
//   DropdownMenuEntry(
//     value: "MJ-3500",
//     label: "MJ-3500",
//   ),
// ];

// /// ==== YAKUMO Machine ==== ///

// List<DropdownMenuEntry> yakumo = [
//   DropdownMenuEntry(
//     value: "380",
//     label: "380",
//   ),
// ];

// /// ==== YAMATO Machine ==== ///

// List<DropdownMenuEntry> yamato = [
//   DropdownMenuEntry(
//     value: "VC-2700",
//     label: "VC-2700",
//   ),
//   DropdownMenuEntry(
//     value: "AZ-8020SD",
//     label: "AZ-8020SD",
//   ),
//   DropdownMenuEntry(
//     value: "AZ-7500SDR",
//     label: "AZ-7500SDR",
//   ),
// ];

// /// ==== HIKARI Machine ==== ///

// List<DropdownMenuEntry> hikari = [
//   DropdownMenuEntry(
//     value: "HX-688T-14-03",
//     label: "HX-688T-14-03",
//   ),
//   DropdownMenuEntry(
//     value: "HX-688T-16-03",
//     label: "HX-688T-16-03",
//   ),
// ];

// /// ==== GOLDEN WHEEL Machine        29/05/24==== ///

// List<DropdownMenuEntry> golden_wheel = [
//   DropdownMenuEntry(
//     value: "CSTA-2614-M03",
//     label: "CSTA-2614-M03",
//   ),
// ];

// /// ==== JACK Machine ==== ///

// List<DropdownMenuEntry> jack = [
//   DropdownMenuEntry(
//     value: "A5E-A-W",
//     label: "A5E-A-W",
//   ),
// ];

// /// ==== KANSAI Machine ==== ///

// List<DropdownMenuEntry> kansai = [
//   DropdownMenuEntry(
//     value: "FX-4404PK",
//     label: "FX-4404PK",
//   ),
//   DropdownMenuEntry(
//     value: "FX-4425PW-UTC",
//     label: "FX-4425PW-UTC",
//   ),
//   DropdownMenuEntry(
//     value: "FX-4421PMD",
//     label: "FX-4421PMD",
//   ),
//   DropdownMenuEntry(
//     value: "FX-4423PMD",
//     label: "FX-4423PMD",
//   ),
//   DropdownMenuEntry(
//     value: "DFB-1404PK",
//     label: "DFB-1404PK",
//   ),
//   DropdownMenuEntry(
//     value: "NB-1433PS",
//     label: "NB-1433PS",
//   ),
//   DropdownMenuEntry(
//     value: "RX-9803A-CC/UTC",
//     label: "RX-9803A-CC/UTC",
//   ),
//   DropdownMenuEntry(
//     value: "NB-2803",
//     label: "NB-2803",
//   ),
//   DropdownMenuEntry(
//     value: "NR-9803A-GCC/UTAB",
//     label: "NR-9803A-GCC/UTAB",
//   ),
//   DropdownMenuEntry(
//     value: "NR-9803GALK-UTAB",
//     label: "NR-9803GALK-UTAB",
//   ),
//   DropdownMenuEntry(
//     value: "KC-2803UTC",
//     label: "KC-2803UTC",
//   ),
//   DropdownMenuEntry(
//     value: "FW-730",
//     label: "FW-730",
//   ),
//   DropdownMenuEntry(
//     value: "NM-1103CL",
//     label: "NM-1103CL",
//   ),
//   DropdownMenuEntry(
//     value: "MZ-1103C/UTC",
//     label: "MZ-1103C/UTC",
//   ),
//   DropdownMenuEntry(
//     value: "RX-9803A-GC",
//     label: "RX-9803A-GC",
//   ),
//   DropdownMenuEntry(
//     value: "NW-8803GD/UTAB",
//     label: "NW-8803GD/UTAB",
//   ),
//   DropdownMenuEntry(
//     value: "FSX-6604MH-60",
//     label: "FSX-6604MH-60",
//   ),
//   DropdownMenuEntry(
//     value: "NC-1103GLC-UTAB",
//     label: "NC-1103GLC-UTAB",
//   ),
//   DropdownMenuEntry(
//     value: "UK-1014H-O1MX3",
//     label: "UK-1014H-O1MX3",
//   ),
//   DropdownMenuEntry(
//     value: "UK-2014H-O1MX03",
//     label: "UK-2014H-O1MX03",
//   ),
//   DropdownMenuEntry(
//     value: "UK-2004S-OM",
//     label: "UK-2004S-OM",
//   ),
//   DropdownMenuEntry(
//     value: "UK-1116S-O1X4",
//     label: "UK-1116S-O1X4",
//   ),
//   DropdownMenuEntry(
//     value: "UK-2116S-O1X4",
//     label: "UK-2116S-O1X4",
//   ),
//   DropdownMenuEntry(
//     value: "JJ-3014GH",
//     label: "JJ-3014GH",
//   ),
//   DropdownMenuEntry(
//     value: "NL-5802GL",
//     label: "NL-5802GL",
//   ),
//   DropdownMenuEntry(
//     value: "NL-5802GLR",
//     label: "NL-5802GLR",
//   ),
//   DropdownMenuEntry(
//     value: "LX-5803-2L",
//     label: "LX-5803-2L",
//   ),
//   DropdownMenuEntry(
//     value: "LX-5802L",
//     label: "LX-5802L",
//   ),
//   DropdownMenuEntry(
//     value: "NL-5802L",
//     label: "NL-5802L",
//   ),
//   DropdownMenuEntry(
//     value: "ZJ-5821A-04",
//     label: "ZJ-5821A-04",
//   ),
// ];

// /// ==== Pacer ==== ///

// List<DropdownMenuEntry> pacer = [
//   DropdownMenuEntry(
//     value: "GP4-5",
//     label: "GP4-5",
//   ),
// ];
// //=======================================================================================
// //
// //                              NON-SEWING MACHINE BRAND
// //
// //=======================================================================================

// /// ==== Reach Peace Machine ==== ///

// List<DropdownMenuEntry> richpeace = [
//   DropdownMenuEntry(
//     value: "RP-5",
//     label: "RP-5",
//   ),
// ];

// /// ==== None ==== ///

// List<DropdownMenuEntry> none = [
//   DropdownMenuEntry(
//     value: "Nill",
//     label: "Nill",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 740",
//     label: "HTM 740",
//   ),
//   DropdownMenuEntry(
//     value: "CB 2000",
//     label: "CB 2000",
//   ),
// ];

// /// ==== Prym ==== ///

// List<DropdownMenuEntry> prym = [
//   DropdownMenuEntry(
//     value: "PP5/600",
//     label: "PP5/600",
//   ),
// ];

// /// ==== YoungOne ==== ///

// List<DropdownMenuEntry> youngone = [
//   DropdownMenuEntry(
//     value: "SC 100X125",
//     label: "SC 100X125",
//   ),
//   DropdownMenuEntry(
//     value: "SC 80X75",
//     label: "SC 80X75",
//   ),
//   DropdownMenuEntry(
//     value: "SC 80X100",
//     label: "SC 80X100",
//   ),
//   DropdownMenuEntry(
//     value: "Nill",
//     label: "Nill",
//   ),
// ];

// /// ==== Seung Min ==== ///

// List<DropdownMenuEntry> seungmin = [
//   DropdownMenuEntry(
//     value: "SM 300",
//     label: "SM 300",
//   ),
// ];

// /// ==== YoungOne ==== ///

// List<DropdownMenuEntry> bealead = [
//   DropdownMenuEntry(
//     value: "DF-2402-X",
//     label: "DF-2402-X",
//   ),
//   DropdownMenuEntry(
//     value: "DF-4402-X",
//     label: "DF-4402-X",
//   ),
//   DropdownMenuEntry(
//     value: "BL-828 B",
//     label: "BL-828-B",
//   ),
//   DropdownMenuEntry(
//     value: "Nill",
//     label: "Nill",
//   ),
// ];

// /// ==== YGA ==== ///

// List<DropdownMenuEntry> yga = [
//   DropdownMenuEntry(
//     value: "Nill",
//     label: "Nill",
//   ),
// ];

// /// ==== Nawon ==== ///

// List<DropdownMenuEntry> nawon = [
//   DropdownMenuEntry(
//     value: "HTM 739",
//     label: "HTM 739",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 3777",
//     label: "HTM 3777",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 5533",
//     label: "HTM 5533",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 5588",
//     label: "HTM 5588",
//   ),
//   DropdownMenuEntry(
//     value: "SSM 2411 SF",
//     label: "SSM 2411 SF",
//   ),
//   DropdownMenuEntry(
//     value: "2499T-FSF",
//     label: "2499T-FSF",
//   ),
//   DropdownMenuEntry(
//     value: "NW P8",
//     label: "NW P8",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 2100",
//     label: "HTM 2100",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 2111",
//     label: "HTM 2111",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 2116",
//     label: "HTM 2116",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 2116-2",
//     label: "HTM 2116-2",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 2222",
//     label: "HTM 2222",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 2225A",
//     label: "HTM 2225A",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 749",
//     label: "HTM 749",
//   ),
//   DropdownMenuEntry(
//     value: "HTM N7801",
//     label: "HTM N7801",
//   ),
//   DropdownMenuEntry(
//     value: "HTM 6849",
//     label: "HTM 6849",
//   ),
//   DropdownMenuEntry(
//     value: "Nill",
//     label: "Nill",
//   ),
// ];

// /// ==== Suzuki ==== ///

// List<DropdownMenuEntry> suzuki = [
//   DropdownMenuEntry(
//     value: "SUH 30",
//     label: "SUH 30",
//   ),
// ];

// /// ==== CHUNDONG ==== ///

// List<DropdownMenuEntry> chundong = [
//   DropdownMenuEntry(
//     value: "SJN 600",
//     label: "SJN 600",
//   ),
// ];

// /// ==== YRC ==== ///

// List<DropdownMenuEntry> yrc = [
//   DropdownMenuEntry(
//     value: "Nill",
//     label: "Nill",
//   ),
// ];

// /// ==== Silver Star ==== ///

// List<DropdownMenuEntry> silverstar = [
//   DropdownMenuEntry(
//     value: "SR 6000",
//     label: "SR 6000",
//   ),
// ];

// /// ==== EB Electronic ==== ///

// List<DropdownMenuEntry> ebelectronic = [
//   DropdownMenuEntry(
//     value: "EB-3",
//     label: "EB-3",
//   ),
// ];

// /// ==== Cutex ==== ///

// List<DropdownMenuEntry> cutex = [
//   DropdownMenuEntry(
//     value: "TR-PL",
//     label: "TR-PL",
//   ),
//   DropdownMenuEntry(
//     value: "TR-3N",
//     label: "TR-3N",
//   ),
// ];

// /// ==== E.B.E.B.C ==== ///

// List<DropdownMenuEntry> ebebc = [
//   DropdownMenuEntry(
//     value: "EB-3",
//     label: "EB-3",
//   ),
// ];

// /// ==== Xinding ==== ///

// List<DropdownMenuEntry> xinding = [
//   DropdownMenuEntry(
//     value: "XD-818",
//     label: "XD-818",
//   ),
// ];

// /// ==== Xinding ==== ///

// List<DropdownMenuEntry> enntech = [
//   DropdownMenuEntry(
//     value: "DH-06",
//     label: "DH-06",
//   ),
// ];

// /// ==== YKK ==== ///

// List<DropdownMenuEntry> ykk = [
//   DropdownMenuEntry(
//     value: "GNS",
//     label: "GNS",
//   ),
//   DropdownMenuEntry(
//     value: "N6-S",
//     label: "N6-S",
//   ),
// ];

// /// ==== Moritto ==== ///

// List<DropdownMenuEntry> moritto = [
//   DropdownMenuEntry(
//     value: "YM 160",
//     label: "YM 160",
//   ),
// ];

// /// ==== SkyLine ==== ///

// List<DropdownMenuEntry> skyline = [
//   DropdownMenuEntry(
//     value: "SL-F14B",
//     label: "SL-F14B",
//   ),
// ];

// /// ==== Support ==== ///

// List<DropdownMenuEntry> support = [
//   DropdownMenuEntry(
//     value: "SUL 100",
//     label: "SUL 100",
//   ),
// ];

// /// ==== CHUN MASTER ==== ///

// List<DropdownMenuEntry> chunmaster = [
//   DropdownMenuEntry(
//     value: "CM 200",
//     label: "CM 200",
//   ),
//   DropdownMenuEntry(
//     value: "CM 1500D",
//     label: "CM 1500D",
//   ),
// ];

// /// ==== LG Chem Ltd ==== ///

// List<DropdownMenuEntry> lgchem = [
//   DropdownMenuEntry(
//     value: "C74RGQ",
//     label: "C74RGQ",
//   ),
// ];

// /// ==== AND ==== ///

// List<DropdownMenuEntry> and = [
//   DropdownMenuEntry(
//     value: "HC 314",
//     label: "HC 314",
//   ),
// ];
