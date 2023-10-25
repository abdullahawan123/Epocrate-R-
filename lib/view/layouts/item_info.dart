import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("About Courses", style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
            SizedBox(
              height: .5.h,
            ),
            Text("This supplementary course is offered with QABA accreditation to cover autism topics and basic concepts. For those wishing to complete the first requirement to obtain an ABAT license", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
            SizedBox(
              height: 2.h,
            ),
            Text("Requirements", style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
            SizedBox(
              height: .5.h,
            ),
            Text(" > RBT 40 Hours Training Course", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
            SizedBox(
              height: 2.h,
            ),
            Text("Features", style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
            SizedBox(
              height: .5.h,
            ),
            Text(" > Remote in time for you [ Recorded ]", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
            SizedBox(
              height: .5.h,
            ),
            Text(" > Short tests", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
            SizedBox(
              height: .5.h,
            ),
            Text(" > 30 days to access the course content", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
            SizedBox(
              height: .5.h,
            ),
            Text(" > 20% discount on 2nd requirement", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
            SizedBox(
              height: .5.h,
            ),
            Text(" > Technical Support via Whatsapp and Email", style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),

          ],
        ),
      )
    );
  }
}
