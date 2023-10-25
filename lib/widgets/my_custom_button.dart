import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../helpers/constants.dart';

class MyCustomButton extends StatelessWidget {
  String text;
  double? size;
  Callback onTap;
    bool? isRound;
    double? width;
    double? height;
  Color? buttonColor;
  Color? textColor;
  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin:EdgeInsets.symmetric(vertical:10),
        alignment: Alignment.center,
        height:height?? 40,
        width: width,
        decoration: BoxDecoration(
          borderRadius: isRound==true?BorderRadius.circular(30):BorderRadius.circular(7),
          color: buttonColor??appPrimaryColor,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize:size ?? 18,
              decoration: TextDecoration.none,
              color: textColor??Colors.white),
        ),
      ),
    );
  }

  MyCustomButton({
    required this.text,
    this.size,
    required this.onTap,
    this.isRound,
    this.width,
    this.height,
    this.buttonColor,
    this.textColor,
     this.margin,
  });
}
