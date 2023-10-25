import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/view/screens/screen_payment.dart';
import 'package:sizer/sizer.dart';

class ScreenPaymentMethod extends StatelessWidget {
  const ScreenPaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Image.asset("assets/images/img.png", fit: BoxFit.fill,)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Payment Method",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(
            onTap: (){
              Get.to(ScreenPayment());
            },
            child: Container(
              alignment: Alignment.center,
              height: 30.h,
              width: 80.w,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(0,1),
                        spreadRadius: 5,
                        blurRadius: 7
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
              ),
                child: Column(
                  children: [
                    Image.asset("assets/images/mastercard.jpeg",fit: BoxFit.fill,),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text("Activated",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),)
                  ],
                )),
          ),
          Container(
            height: 30.h,
            width: 80.w,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(0,1),
                      spreadRadius: 5,
                      blurRadius: 7
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
            ),
              child: Column(
                children: [
                  Image.asset("assets/images/applepay.jpeg",fit: BoxFit.fill,),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text("Not Activated",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),)
                ],
              )),
          SizedBox(
            height: 2.5.h,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: Color(0xff222448),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
