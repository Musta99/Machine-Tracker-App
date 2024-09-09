import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TestCode extends StatefulWidget {
  TestCode({Key? key}) : super(key: key);

  @override
  State<TestCode> createState() => _TestCodeState();
}

class _TestCodeState extends State<TestCode> {
  String floor = "";
  String serial = "";
  String unit = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination Flutter"),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  floor = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Type Floor Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  serial = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Type Machine Serial",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  unit = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Type Factory Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              height: 400,
              child: FirestorePagination(
                query: FirebaseFirestore.instance
                    .collection("Transfer")
                    .orderBy("date"),
                itemBuilder: (context, snapshot, index) {
                  // Apply filtering here
                  if (floor.isNotEmpty && snapshot["allocatedFloor"] != floor) {
                    return SizedBox.shrink(); // Hide if not matching floor
                  }
                  if (serial.isNotEmpty &&
                      snapshot["machineSerial"] != serial) {
                    return SizedBox.shrink(); // Hide if not matching serial
                  }
                  if (unit.isNotEmpty && snapshot["factoryName"] != unit) {
                    return SizedBox.shrink(); // Hide if not matching serial
                  }
                  // If no filters or matches found, display the item
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text("Date : ${snapshot["date"]}"),
                            Row(
                              children: [
                                Text("Model :"),
                                Card(
                                  color: Color(0xff93c9f6),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot["machineModel"]),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Serial :"),
                                Card(
                                  color: Color(0xff93c9f6),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot["machineSerial"]),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("In Floor :"),
                                    Card(
                                      color: Color(0xffa1e3a4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot["allocatedFloor"]),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Out Floor :"),
                                    Card(
                                      color: Color(0xfff09999),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot["outFloor"]),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text("Shifted By : ${snapshot["userName"]}"),
                            TextButton(
                              onPressed: () {},
                              child: Text("Details"),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
