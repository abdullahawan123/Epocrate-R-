import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/helpers/helper.dart';
import 'package:rushd/helpers/style.dart';
import 'package:rushd/models/batch.dart';
import 'package:rushd/view/screens/screen_home.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/constants.dart';
import '../../models/assignment_content.dart';
import '../../models/batch_content.dart';
import '../../models/live_content.dart';
import '../../models/recorded_content.dart';
import '../../widgets/my_custom_button.dart';
import '../layouts/item_course_about.dart';
import '../layouts/item_course_registration.dart';
import '../layouts/item_course_reviews.dart';
import '../layouts/layout_cart.dart';

class ScreenCourses extends StatefulWidget {
Batch batch;

  @override
  State<ScreenCourses> createState() => _ScreenCoursesState();

ScreenCourses({
    required this.batch,
  });
}

class _ScreenCoursesState extends State<ScreenCourses> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("GRADUATES",style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            leading:    IconButton(onPressed: () {
              Get.back();
            },
                icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
            actions: [
              Image.asset("assets/images/img_5.png",height: 6.h,width:10.w,),
            ],
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: batchesRef.doc(widget.batch.id).collection("courseContent").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState==ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
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
              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      margin: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12.sp)),
                        color: Colors.white,boxShadow: appBoxShadow
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.batch.status,style: TextStyle(color: appPrimaryColor,fontSize: 14.sp),).marginSymmetric(vertical: 4),
                            Container(
                                height: 25.sp,width: 25.sp,
                                child: Image.asset("assets/images/ic_launcher.png",fit: BoxFit.cover,))

                          ],
                        ),
                        Text(widget.batch.name,style: TextStyle(color: appPrimaryColor,fontSize: 14.sp),).marginSymmetric(vertical: 4),
                        Text(widget.batch.description,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: appPrimaryColor,fontSize: 14.sp),).marginSymmetric(vertical: 4),

                          Row(
                              children: [
                                Text("Assignments : "),
                                Text(assignments.length.toString()),

                              ],
                            ),
                          Row(
                              children: [
                                Text("Recorded Lectures : "),
                                Text(recordedContent.length.toString()),

                              ],
                            ),
                          Row(
                              children: [
                                Text("Announcement Lectures : "),
                                Text(announcements.length.toString()),

                              ],
                            ),
                            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyCustomButton(
                                margin: EdgeInsets.zero,
                                height: 25.sp,
                                isRound: true,
                                text: "Course", onTap: (){
                              // Get.to(ScreenCourses());
                            }),

                            Row(
                                  children: [
                                    Icon(Icons.star,color: Color(0xFFD47A10),),
                                    Text("4.5"),
                                  ],
                                ),
                                Text(widget.batch.price.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.blue),),
                          ],
                        ),
                      ],),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        boxShadow: appBoxShadow,
                        color: Colors.white
                      ),
                      child: TabBar(

                        labelColor: Colors.white,
                        unselectedLabelColor: appPrimaryColor,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: appPrimaryColor

                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        // ignore: prefer_const_literals_to_create_immutables
                        tabs: [
                          Tab(
                          text: "About",
                          ),
                          Tab(
                           text: "Reviews",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        ItemCourseAbout(description: widget.batch.description,),
                        // ItemCourseRegistration(),
                        ItemCourseReviews(),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyCustomButton(text: "Register Course",
                            isRound: true,
                            onTap: (){
                          Get.to(ItemCourseRegistration(batch: widget.batch,));
                        }),
                        MyCustomButton(text: "Add to cart",
                            isRound: true,
                            onTap: (){
                          addToCart(widget.batch.id);
                          // Get.to(ItemCourseRegistration());
                        }),
                        // Container(
                        //   margin: EdgeInsets.all(8),
                        //   padding: EdgeInsets.symmetric(vertical: 18,horizontal: 28),
                        //   decoration: BoxDecoration(
                        //     color: Colors.blue,
                        //     borderRadius: BorderRadius.circular(15),
                        //
                        //   ),
                        //   child: Text("Add to cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),),
                        // ),
                      ],
                    ),



                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

final CollectionReference usersRef = FirebaseFirestore.instance.collection("users");

final CollectionReference coursesRef = FirebaseFirestore.instance.collection("courses");

void addToCart(String courseId) {
  // Get course details from the courses collection
  coursesRef.doc(courseId).get().then((courseDoc) {
    if (courseDoc.exists) {
      Map<String, dynamic> courseData = courseDoc.data() as Map<String, dynamic>;
      CartItem cartItem = CartItem(
        courseId: courseId,
        courseName: courseData['name'],
        price: courseData['price'],
      );

      // Add the course to the user's cart
      usersRef.doc(uid).collection("cart").doc(courseId).set({
        'courseId': cartItem.courseId,
        'courseName': cartItem.courseName,
        'price': cartItem.price,
      }).then((_) {
        // Update the UI or show a success message
        setState(() {
          // Course added to cart
        });
      });
    }
  });
}
}
