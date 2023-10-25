import 'package:flutter/material.dart';

class ItemGrades extends StatelessWidget {
  const ItemGrades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment:Alignment.center,
          child: Text("Grades Not Uploaded")),
    );
  }
}
