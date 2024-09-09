import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final String title;
  const ButtonContainer({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: Color(0xffFFC946)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height * 0.018,
          ),
        ),
      ),
    );
  }
}
