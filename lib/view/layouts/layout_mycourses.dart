
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rushd/helpers/firebase_utils.dart';
import 'package:rushd/helpers/helper.dart';
import 'package:rushd/helpers/style.dart';
import 'package:rushd/widgets/custom_listview_builder.dart';
import 'package:sizer/sizer.dart';

import '../../models/batch.dart';
import 'item_course_card.dart';




class LayoutMycourses extends StatelessWidget {
  //
  // get selectedIndex => null;
  // final List<Widget> _widgetOptions = <Widget>[       Text('Search'),    Text('My Courses'),    Text('Cart'),    Text('Profile'),  ];
  // int _selectedIndex = 0;
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  Future<List<Batch>> fetchStudentBatches( List<Batch> batches) async {
    List<Future<DocumentSnapshot<Map<String, dynamic>>>> studentSnapshotsFutures = [];

    for (Batch batch in batches) {
      studentSnapshotsFutures.add(
          batchesRef
              .doc(batch.id)
              .collection("Students")
              .doc(FirebaseUtils.myId)
              .get()
      );
    }

    List<DocumentSnapshot<Map<String, dynamic>>>
    studentSnapshots = await Future.wait(studentSnapshotsFutures);
    List<Batch> studentBatches = [];
    for (int i = 0; i < studentSnapshots.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> studentSnapshot = studentSnapshots[i];
      if (studentSnapshot.exists) {
        studentBatches.add(batches[i]);
      }
    }

    return studentBatches;
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("My Courses",style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.w400,),),
        actions: [
          Image.asset("assets/images/logo.png",fit: BoxFit.fill, height: 90, width:130,),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(

        future: batchesRef.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List<Batch> batches=snapshot.data!.docs.map((e) => Batch.fromMap(e.data() as Map<String,dynamic>)).toList();
// Assuming you have the user's ID stored in the 'id' variable



          return FutureBuilder<List<Batch>>(
            future: fetchStudentBatches(batches),
            builder: (context, snapshot) {
              if (snapshot.connectionState==ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text("No data available"));
              }
              List<Batch> myBatches=snapshot.data!.toSet().toList();
              var completedBatch=myBatches.where((e) => e.status=="Completed").toSet().toList();
              // final matchingBatch = myBatches.firstWhere((element) => element.status == "Completed");
              return (myBatches.isEmpty)?Center(child: Text("You are not enroll to any Course")): SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text("Learn",style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700,fontFamily: 'OFL.ttf',),),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text("Keep learning to make progress ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                    SizedBox(
                      height: 1.h,

                    ),
                     CustomListviewBuilder( itemCount: snapshot.data!.length, scrollDirection: CustomDirection.horizontal, itemBuilder: (BuildContext context, int index) {
                      var batch=myBatches[index];
                      return ItemCourseCard(batch: batch,myCourse: "Yes",);
                    },),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           width: 0.3,
                    //
                    //         ),
                    //       ),
                    //       child: Image.asset("assets/images/img_11.png",height: 110, width:110,),
                    //
                    //     ),
                    //     Column(
                    //       children: [
                    //         Text("Proficiency Assessment - ABAT  Competency Assessment",style: TextStyle(fontWeight: FontWeight.w600),),
                    //         SizedBox(
                    //           height: 35,
                    //         ),
                    //         Text("Overall progress 70%",style: TextStyle(fontWeight: FontWeight.w500,),),
                    //         SizedBox(
                    //           height: 3,
                    //         ),
                    //         LinearPercentIndicator(
                    //           progressColor: Color(0xff22244A),
                    //           width: 190.0,
                    //           lineHeight: 13.0,
                    //           percent: 0.7,
                    //
                    //         ),
                    //
                    //       ],
                    //     )
                    //   ],
                    // ),


                    Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),

                    Row(
                      children: [
                        Text("More Courses",style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                      ],
                    ),

                    CustomListviewBuilder(
                        itemBuilder: (BuildContext context, int index) {
                          Batch batch=batches[index];
                          return  ItemCourseCard(batch: batch,myCourse: "No",);
                        },
                        itemCount: batches.length, scrollDirection: CustomDirection.horizontal

    ),

                    Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),

                    Text("Achievements",style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                    (completedBatch.isEmpty)?Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: appBoxShadow
                        ),
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Text("You have Not Completed any Course Yet")): CustomListviewBuilder(
                        itemBuilder: (BuildContext context, int index) {
                          Batch batch=completedBatch[index];
                          return  ItemCourseCard(batch: batch,myCourse: "Yes",);
                        },
                        itemCount: completedBatch.length, scrollDirection: CustomDirection.horizontal

                    ),

                  ]

                ),
              );
            }
          );
        }
      ),


    );

  }
}
