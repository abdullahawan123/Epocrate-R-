import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class ScreenPayment extends StatelessWidget {
  const ScreenPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed: () {
          Get.back(); },),
        actions: [
          Image.asset("assets/images/img.png", fit: BoxFit.fill,)
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 4.h,
          ),
          Text("Add Credit card Details",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Full Name",
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Credit card Number",
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Expiry Date",
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "CVV Code",
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
          SizedBox(
            height: 30.h,
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
          )
        ],
      ),
    );
  }
}
