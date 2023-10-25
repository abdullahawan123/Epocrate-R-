import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  String text;
  Color? color;
  double? size;
  FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight?? FontWeight.w400,
        fontSize: size ?? 14,
        fontFamily: 'Poppins',
        color: color ?? Colors.black,
      ),
    );
  }

  SmallText({
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
  });
}
