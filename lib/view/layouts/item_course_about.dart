import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';
import 'package:rushd/helpers/constants.dart';
import 'package:rushd/view/layouts/item_course_registration.dart';
import 'package:sizer/sizer.dart';

class ItemCourseAbout extends StatelessWidget {
String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Text("About Course",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w800),),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(description,style: TextStyle(fontSize: 14),),
              // ),
          ReadMoreText(
            description,
            trimLines: 9,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: '  Show more',
            trimExpandedText: '   Show less',

            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blue),
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blue),
          ),


            ],
          ),
        ),
      ),
    );
  }

ItemCourseAbout({
    required this.description,
  });
}
