import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rushd/widgets/small_text.dart';

import '../helpers/constants.dart';
import 'large_text.dart';
import 'medium_text.dart';

class CustomContainer extends StatelessWidget {
  VoidCallback onTap;
  String subtitle;
  Widget title;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: EdgeInsets.all(6),
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: appPrimaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: title,
              subtitle: MediumText(
                text: subtitle,
                color: Colors.white,
              ),
              trailing: icon,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SmallText(
                  text: "More Info ",
                  color: Colors.white,
                ),
                SvgPicture.asset("assets/images/arrow.svg"),
              ],
            ).marginOnly(bottom: 5)
          ],
        ),
      ),
    );
  }

  CustomContainer({
    required this.onTap,
    required this.subtitle,
    required this.title,
    required this.icon,
  });
}
