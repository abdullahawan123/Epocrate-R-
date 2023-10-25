import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:rushd/view/screens/screen__registration.dart';
import 'package:sizer/sizer.dart';

class ScreenVerification extends StatelessWidget {
  const ScreenVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed: () {
          Get.back();
        },),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
                child: Image.asset("assets/images/verification.png")),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Verification",style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Enter the OTP code sent to your phone",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
            ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            alignment: Alignment.center,
            child: Pinput(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              length: 4,


            ),
          ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.center,
                child: Text("Did not receive a code?",style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w600),)),
            SizedBox(
              height: 2.h,
            ),
            Align(
              alignment: Alignment.center,
                child: Text("RESEND",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w800),)),
            SizedBox(
              height: 8.h,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: (){
                  Get.to(ScreenVerification());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35.w,vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: Color(0xff222448),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text("Done",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(onPressed: () {

              },
              child: Text("Change phone number?",style:TextStyle(fontWeight: FontWeight.w600,fontSize: 15),)),
            )
          ]
        ),
      ),
    );
  }
}
