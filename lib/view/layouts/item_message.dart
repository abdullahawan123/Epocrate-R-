import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/helper.dart';


class BubbleSpecialOne extends StatelessWidget {
  final bool isSender;
  final String text;
  final bool tail;
  final Color color;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;
  final String? profileImage;

  const BubbleSpecialOne({
    Key? key,
    this.isSender = true,
    required this.text,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.profileImage,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: isSender?
      Container(
        padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: isSender?Border():Border.all(color: Colors.black.withOpacity(.1)),
          color:isSender? appPrimaryColor.withOpacity(.1):Colors.white,
          borderRadius: isSender?BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)):BorderRadius.circular(4),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .7,
        ),
        margin: isSender
            ? stateTick
            ? EdgeInsets.fromLTRB(7, 7, 14, 7)
            : EdgeInsets.fromLTRB(7, 7, 17, 7)
            : EdgeInsets.fromLTRB(17, 7, 7, 7),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: stateTick
                  ? EdgeInsets.only(right: 20)
                  : EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Text(
                text,
                style: TextStyle(color: isSender?appPrimaryColor:Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            stateIcon != null && stateTick
                ? Positioned(
              bottom: 0,
              right: 0,
              child: stateIcon,
            )
                : SizedBox(
              width: 1,
            ),
          ],
        ),
      ):
      Row(
        children: [
          CircleAvatar(
            backgroundImage:NetworkImage("${profileImage == null ?userPlaceHolder:profileImage } ?userPlaceHolder:profileImage"),
          ),
          SizedBox(width: 3),
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: isSender?Border():Border.all(color: Colors.black.withOpacity(.1)),
              color:isSender? appPrimaryColor.withOpacity(.1):Colors.white,
              borderRadius: isSender?BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)):BorderRadius.circular(4),
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .7,
            ),
            margin: isSender
                ? stateTick
                ? EdgeInsets.fromLTRB(7, 7, 14, 7)
                : EdgeInsets.fromLTRB(7, 7, 17, 7)
                : EdgeInsets.fromLTRB(17, 7, 7, 7),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: stateTick
                      ? EdgeInsets.only(right: 20)
                      : EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Text(
                    text,
                    style: TextStyle(color: isSender?appPrimaryColor:Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                stateIcon != null && stateTick
                    ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: stateIcon,
                )
                    : SizedBox(
                  width: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
