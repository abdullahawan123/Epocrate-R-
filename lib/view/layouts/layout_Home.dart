import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rushd/helpers/helper.dart';
import 'package:rushd/models/batch.dart';
import 'package:rushd/view/layouts/item_course_card.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/custom_listview_builder.dart';
import '../screens/screen_courses.dart';
import 'item_sessions.dart';
import 'item_topcourses.dart';

class LayoutHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: batchesRef.snapshots(),
          builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List<Batch> batches=snapshot.data!.docs.map((e) => Batch.fromMap(e.data() as Map<String,dynamic>)).toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        "assets/images/img_5.png",
                        height: 6.h,
                        width: 10.w,
                      )),
                  Row(
                    children: [
                      Text(
                        "TOP COURSES",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset("assets/images/courseicon.png"),
                    ],
                  ),
                  (batches.isNotEmpty)?CustomListviewBuilder(
                    itemCount: batches.length,

                    itemBuilder: (BuildContext context, int index) {
                      Batch batch=batches[index];
                      return ItemCourseCard(batch: batch,);
                    }, scrollDirection: CustomDirection.horizontal,
                  ):Center(child: Text("No Course Yet"),),
                  Row(
                    children: [
                      Text(
                        "Sessions",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      SizedBox(
                          height: 25.sp,
                          width: 25.sp,
                          child: Image.asset("assets/images/img_7.png")),
                    ],
                  ),

                ],
              ).marginSymmetric(horizontal: 10.sp),
            );
          }
        ),
        // drawer: Drawer(
        //   child: SingleChildScrollView(
        //     child: Container(
        //       child: Column(
        //         children: [
        //           SizedBox(
        //             height: 10.h,
        //           ),
        //           ListTile(
        //             onTap: (){
        //               // Get.to(ScreenSearchHistory());
        //             },
        //             title: Text("Edit Profile"),
        //             trailing: Icon(Icons.arrow_forward_ios),
        //           ),
        //           Divider(),
        //           ListTile(
        //             onTap: (){
        //               // Get.to(ScreenDownloadImages());
        //             },
        //             title: Text("Notification"),
        //             trailing: Icon(Icons.arrow_forward_ios),
        //           ),
        //           Divider(),
        //           ListTile(
        //             onTap: (){
        //               // Get.to(ScreenFeedback());
        //             },
        //             title: Text("Myself"),
        //             trailing: Icon(Icons.arrow_forward_ios),
        //           ),
        //           Divider(),
        //           ListTile(
        //             onTap: (){
        //               // Get.to(ScreenSettings());
        //             },
        //             title: Text("Calender"),
        //             trailing: Icon(Icons.arrow_forward_ios),
        //           ),
        //           Divider(),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
