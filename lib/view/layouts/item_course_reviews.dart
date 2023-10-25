import 'package:flutter/material.dart';

class ItemCourseReviews extends StatelessWidget {
  const ItemCourseReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
          child: Text("There are no Reviews")),
    );
  }
}
