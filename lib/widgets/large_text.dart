import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  String text;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w600,
        fontSize: 30,
        fontFamily: 'Poppins',
        color: color ?? Color(0xff1B1B1B),
      ),
    );
  }

  LargeText({required this.text, this.color});
}
