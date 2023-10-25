import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rushd/view/screens/screen_home.dart';
import 'package:rushd/view/screens/screen_welcome.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser==null?Get.offAll(ScreenWelcome()):Get.offAll(ScreenHome());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 20.sp,
              right: 20.sp,
              top: 0,
              bottom: 0,
              child: Image.asset("assets/images/logo.png")),
          Positioned(
            top: -70,
            left: -60,
            child: Container(
              height: 25.h,
              width: 50.w,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xff222548),
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: -120,
            left: 20,
            child: Container(
              height: 25.h,
              width: 50.w,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xffB9D2E8),
                  shape: BoxShape.circle
              ),
            ),
          ),
        ],
      ),
    );
  }
}
