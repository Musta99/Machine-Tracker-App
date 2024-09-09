import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  String keyData;
  String valueData;
  InformationCard({
    Key? key,
    required this.keyData,
    required this.valueData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.7),
        ),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              keyData,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                valueData,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
