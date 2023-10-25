import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RoundedProgressBar extends StatefulWidget {
  final double percent;
  final double height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? paddingChildLeft;
  final EdgeInsetsGeometry? paddingChildRight;
  final Widget? childCenter;
  final Widget? childLeft;
  final Widget? childRight;
  final bool reverse;
  final int milliseconds;
  final Color? activeColor;
  final BorderRadiusGeometry? borderRadius;
  final double radius;

  RoundedProgressBar(
      {this.percent = 95,
        this.height = 50,
        this.activeColor,
        this.margin,
        this.reverse = false,
        this.childCenter,
        this.childLeft,
        this.childRight,
        this.milliseconds = 500,
        this.borderRadius,
        this.paddingChildLeft,
        this.radius = 18,
        this.paddingChildRight}) {
    assert(percent >= 0);
    assert(height > 0);
  }

  @override
  State<StatefulWidget> createState() => RoundedProgressBarState();
}

class RoundedProgressBarState extends State<RoundedProgressBar> {
  late double width;
  double? maxWidth;
  double? widthProgress;
  Widget? childCenter;
  AlignmentGeometry alignment = AlignmentDirectional.centerStart;
  BorderRadiusGeometry? borderRadius;
  EdgeInsetsGeometry? paddingChildLeft;
  EdgeInsetsGeometry? paddingChildRight;

  @override
  void initState() {



    if (widget.reverse) {
      alignment = AlignmentDirectional.centerEnd;
    }

    if (widget.borderRadius == null) {
      borderRadius = BorderRadius.circular(12);
    } else {
      borderRadius = widget.borderRadius;
    }

    if (widget.paddingChildLeft == null) {
      paddingChildLeft = EdgeInsets.all(16);
    } else {
      paddingChildLeft = widget.paddingChildLeft;
    }

    if (widget.paddingChildRight == null) {
      paddingChildRight = EdgeInsets.all(16);
    } else {
      paddingChildRight = widget.paddingChildRight;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        width = constraint.maxWidth;
        widthProgress = width * widget.percent / 100;
        return Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                margin: widget.margin,
                constraints: BoxConstraints.expand(height: widget.height * 1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        alignment: alignment,
                        children: <Widget>[
                          AnimatedContainer(
                            duration: Duration(milliseconds: widget.milliseconds),
                            width: widthProgress,
                            height: widget.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: widget.activeColor,
                            ),
                          ),
                          Center(child: widget.childCenter),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: widget.childLeft,
                          ).paddingOnly(left: 15.sp),
                          Align(
                            alignment: Alignment.centerRight,
                            child: widget.childRight,
                          ).paddingOnly(right: 15.sp)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}