import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import 'screen_payment_method.dart';
import '../layouts/layout_cart.dart';



class ScreenCart extends StatefulWidget {
  const ScreenCart({Key? key}) : super(key: key);

  @override
  State<ScreenCart> createState() => _ScreenCart();
}

class _ScreenCart extends State<ScreenCart> {
  int counter = 0;
  int count = 0;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("Cart",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("2 items",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.3,
                        ),
                      ),
                      child: Image.asset("assets/images/img_15.png",height: 20.h, width:40.w,),


                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("  Number Cards  ",style: TextStyle(fontWeight: FontWeight.w600),),
                        Text("  Print-ready digital file  ",style: TextStyle(fontWeight: FontWeight.w400),),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Text("  0 SAR",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                            SizedBox(
                              width: 6.w,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(),
                              ),
                              child: Row(
                                children: [
                                  ElevatedButton(onPressed: (){
                                    setState(() {
                                      if(counter >=0){
                                        ++counter;
                                      }
                                    });
                                  },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(1,1 ),
                                        primary: Colors.white
                                      ),
                                      child: Icon(Icons.add,color: Colors.black,)),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(counter.toString()),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  ElevatedButton(onPressed: (){
                                    setState(() {
                                      if(counter >0){
                                        --counter;
                                      }
                                    });
                                  },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(5,10 ),
                                          primary: Colors.white
                                      ),
                                      child: Icon(Icons.remove,color: Colors.black,)),
                                ],
                              ),
                            )
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.3,
                        ),
                      ),
                      child: Image.asset("assets/images/img_13.png",height: 20.h, width:40.w,),


                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("  ABAT Supplementary Courses Lecture ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12),),
                        Text(" This supplementary course is offered \n with QABA accreditation ",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Text(" 120 SAR",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                            SizedBox(
                              width: 3.w,
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(),
                              ),
                              child: Row(
                                children: [
                                  ElevatedButton(onPressed: (){
                                    setState(() {
                                      if(count >=0){
                                        ++count;
                                      }
                                    });
                                  },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(1,1 ),
                                          primary: Colors.white
                                      ),
                                      child: Icon(Icons.add,color: Colors.black,)),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(count.toString()),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  ElevatedButton(onPressed: (){
                                    setState(() {
                                      if(count >0){
                                        --count;
                                      }
                                    });
                                  },
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(5,10 ),
                                          primary: Colors.white
                                      ),
                                      child: Icon(Icons.remove,color: Colors.black,)),
                                ],
                              ),
                            )
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sub Total",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    Text("120 SAR",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
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
                    child: Text("Check out",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                        Get.to(ScreenPaymentMethod());
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all()
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Check out with",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
                        SizedBox(
                          width: 2.w,
                        ),
                        Image.asset("assets/images/img_16.png",height: 5.h,width: 15.w,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.center,
                  child: TextButton(child: Text("Continue shopping",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                    onPressed: () {
                    // Get.to(LayoutCart());
                    },)),


            ]
        )
    );
  }
}