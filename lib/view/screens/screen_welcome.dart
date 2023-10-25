import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/helpers/constants.dart';
import 'package:rushd/view/screens/screen__registration.dart';
import 'package:rushd/view/screens/screen_login.dart';
import 'package:sizer/sizer.dart';

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({Key? key}) : super(key: key);

  @override
  _ScreenWelcomeState createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: Column(
        children: [
          Spacer(),
          Align(
              alignment: Alignment.center,
              child: Text(
                "WELCOME",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w800),
              )),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Nurturing Abilities, Embracing Autism",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              )),
         Spacer(),
          Container(
            width: Get.width,
            height: 38.sp,
            margin: EdgeInsets.symmetric(horizontal: 5.w,),
            child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/google.png"),

                    Text(
                      "Sign in with Google",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(width: 10,),
                  ],
                )),
          ),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
            onTap: () {
              Get.to(ScreenRegistration());
            },
            child: Container(
              alignment: Alignment.center,
              width: Get.width,
              height: 38.sp,
              margin: EdgeInsets.symmetric(horizontal: 5.w,),
              decoration: BoxDecoration(
                  color: Color(0xff222448),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 0.5.w)),
              child: Text(
                "Create an account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(ScreenLogin());
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),

          Spacer(),

        ],
      ),
    );
  }
}
