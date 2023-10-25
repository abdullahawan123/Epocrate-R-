import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  String text;
  Color? color;
  double? size;
  FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight?? FontWeight.w600,
        fontSize: size ?? 18,
        fontFamily: 'Poppins',
        color: color ?? Colors.black,
      ),
    );
  }

  MediumText({
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
  });
}
