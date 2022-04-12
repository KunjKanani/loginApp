import 'package:flutter/material.dart';

class TopCustomDesign extends StatelessWidget {
  const TopCustomDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Image.asset(
        "images/signin_top.png",
        height: 250,
      ),
    );
  }
}
