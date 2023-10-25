import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rushd/helpers/style.dart';
import 'package:rushd/models/user.dart';
import 'package:rushd/widgets/custom_listview_builder.dart';
import 'package:rushd/widgets/my_custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/helper.dart';
import '../../models/batch.dart';
import '../screens/screen_course_content.dart';
import '../screens/screen_courses.dart';

class ItemCourseCard extends StatelessWidget {
 Batch batch;
 String? myCourse;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6,vertical: 12.sp),
      padding: EdgeInsets.only(left: 12,right: 12,top: 12),
      width: Get.width*.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: appBoxShadow,
        color: Colors.white

      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("GRADUATES",style: TextStyle(color: textColor,fontSize: 14.sp),).marginSymmetric(vertical: 4),
            Row(
              children: [
                Text(batch.status,style: TextStyle(color: appTextColor,fontSize: 15.sp,fontWeight: FontWeight.w800),),
                // Container(
                //     height: 25.sp,width: 25.sp,
                //     child: Image.asset("assets/images/ic_launcher.png",fit: BoxFit.cover,)),
              ],
            )

          ],
        ),
        Text(batch.name,style: TextStyle(color: textColor,fontSize: 14.sp),).marginSymmetric(vertical: 4),
        Text(batch.description,maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(color: textColor,fontSize: 14.sp),).marginSymmetric(vertical: 4),
        SizedBox(
          height: 30,
          child: StreamBuilder<QuerySnapshot>(
            stream: batchesRef.doc(batch.id).collection("Students").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState==ConnectionState.waiting) {
                return CircularProgressIndicator.adaptive();
              }

              List<User> users=snapshot.data!.docs.map((e) => User.fromMap(e.data() as Map<String,dynamic>)).toList();
              return (users.isEmpty)?Text("No Student Register yet"):CustomListviewBuilder(itemBuilder: (BuildContext context, int index) {
                User user=users[index];
                return CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(user.image.isEmpty?userPlaceHolder:user.image),
              ); }, itemCount: users.length, scrollDirection: CustomDirection.horizontal,).marginSymmetric(vertical: 4);
            }
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyCustomButton(
              margin: EdgeInsets.zero,
                height: 25.sp,
                isRound: true,
                text: (myCourse=="No")?"Enroll Now":"Course", onTap: (){
              (myCourse=="Yes")? Get.to(ScreenCourseContent(batch:batch)):Get.to(ScreenCourses(batch: batch,));
            }),

            Row(
                children: <Widget>[
                  Icon(Icons.star,color: Color(0xFFD47A10),),
                  Text("4.5"),
                ],
              ),
              Text(batch.price.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.blue),),
          ],
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/images/lineblue.png")),

      ],),
    );
  }

 ItemCourseCard({
    required this.batch,
    this.myCourse,
  });
}
