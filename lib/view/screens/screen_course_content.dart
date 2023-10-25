import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/helpers/helper.dart';
import 'package:rushd/models/batch.dart';
import 'package:rushd/view/screens/screen_home.dart';
import 'package:sizer/sizer.dart';

import '../../models/assignment_content.dart';
import '../../models/batch_content.dart';
import '../../models/live_content.dart';
import '../../models/recorded_content.dart';
import '../layouts/item_course_list.dart';
import '../layouts/item_grades.dart';
import '../layouts/item_info.dart';

class ScreenCourseContent extends StatelessWidget {
 Batch batch;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 3,
      child: StreamBuilder<QuerySnapshot>(
          stream: batchesRef
              .doc(batch.id)
              .collection("courseContent").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List<CourseContent> courseContents = snapshot.data!.docs
                .map((e) => CourseContent.fromMap(e.data() as Map<
                String, dynamic>)) // Explicitly cast to Map
                .toList();
            List<Announcement?> announcements = courseContents
                .map((e) => e.announcement) // This might contain both null and non-null announcements
                .whereType<Announcement>() // Filter out only non-null Announcements
                .toList();
            List<RecordedContent?> recordedContent = courseContents
                .map((e) => e.recordings)
                .whereType<RecordedContent>()
                .toList();
            List<AssignmentContent?> assignments = courseContents
                .map((e) => e.assignmentContent)
                .whereType<AssignmentContent>()
                .toList();
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff222448),

                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(onPressed: () {
                            Get.back();
                          },
                              icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(batch.name,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
                        SizedBox(
                          height: 6.h,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff222448)
                    ),
                    child: TabBar(

                      labelColor: Colors.white,
                      indicatorColor: Colors.white,

                      // ignore: prefer_const_literals_to_create_immutables
                      tabs: [
                        Tab(
                          text: "Course",
                        ),
                        Tab(
                          text: "Grades",
                        ),
                        Tab(
                          text: "Info",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      ItemCourseList(courseContents:courseContents, batch: batch,),
                      ItemGrades(),
                      ItemInfo(),
                    ]),
                  )

                ],
              ),
            ),
          );
        }
      ),
    );
  }

 ScreenCourseContent({
    required this.batch,
  });
}
