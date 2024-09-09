import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransferHistory extends StatelessWidget {
  String machineSerial;
  String factoryName;
  TransferHistory({
    Key? key,
    required this.machineSerial,
    required this.factoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Transfer History of ${machineSerial}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Container(
          child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("TransferHistory: ${factoryName}")
            .doc(machineSerial)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var data = snapshot.data;
            if (data == null || !data.exists) {
              return Center(child: Text('No data found'));
            } else {
              var transferHistory =
                  data.data() as Map<String, dynamic>?; // Nullable type
              if (transferHistory == null) {
                return Center(child: Text('Transfer history is null'));
              }
              List<String> dateKeys = transferHistory.keys.toList();
              var firstkey = transferHistory.keys.first;

              if (dateKeys.length == 50) {
                try {
                  FirebaseFirestore.instance
                      .collection("TransferHistory: ${factoryName}")
                      .doc(machineSerial)
                      .update({
                    firstkey: FieldValue.delete(),
                  });
                } catch (err) {
                  print(err.toString());
                }
              }

              return ListView.builder(
                itemCount: dateKeys.length,
                itemBuilder: (context, index) {
                  var date = dateKeys[index];
                  var transferList = transferHistory[date];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text(
                            //   transferList[index]["Serial"],
                            //   style: TextStyle(
                            //       fontSize: 16, fontWeight: FontWeight.bold),
                            // ),
                            Text(
                              "Date: ${date}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: transferList.length,
                        itemBuilder: (context, index) {
                          var item = transferList[index];
                          return Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "In Floor: ${item["Allocated Floor"]}",
                                        style: TextStyle(
                                          color: Color(0xff038507),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Out Floor: ${item["Out Floor"]}",
                                        style: TextStyle(
                                          color: Color(0xff850303),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text("Remarks: ${item["Remarks"]}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            }
          }
        },
      )),
    );
  }
}
