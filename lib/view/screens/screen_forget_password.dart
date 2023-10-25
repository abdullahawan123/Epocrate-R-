import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/view/screens/screen_login.dart';
import 'package:sizer/sizer.dart';

class ScreenForgetPassword extends StatefulWidget {
  const ScreenForgetPassword({Key? key}) : super(key: key);

  @override
  _ScreenForgetPasswordState createState() => _ScreenForgetPasswordState();
}

class _ScreenForgetPasswordState extends State<ScreenForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed: () {
          Get.back();
        },),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Forget Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 25),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Enter your email or phone number linked to your account",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 15),),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.blue.withOpacity(0.22),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(12)
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){

              },
              child: Container(
               padding: EdgeInsets.symmetric(horizontal: 41.w,vertical: 2.h),
                decoration: BoxDecoration(
                  color: Color(0xff222448),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Align(
            alignment: Alignment.center,
              child: Text("Can’t reset your password? ",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),))
        ],
      ),
    );
  }
}
