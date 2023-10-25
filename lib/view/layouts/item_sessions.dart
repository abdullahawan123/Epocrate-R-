import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/view/screens/screen_therapysession.dart';
import 'package:sizer/sizer.dart';

class ItemSessions extends StatelessWidget {
  const ItemSessions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/img_8.png",height: 13.h,width: 22.w,),
                    SizedBox(width: .5.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Parent’s Consultation Session",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18),),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text("A free consultation session aimed at directing the beneficiary families ",style: TextStyle(fontSize: 10),),
                        Text("to the appropriate services and presenting a proposed treatment",style: TextStyle(fontSize: 10),),
                        Text("plan containing the number and type of sessions required",style: TextStyle(fontSize: 10),),
                        Row(

                          children: [
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Text("Free",style: TextStyle(color: Colors.blue,fontSize: 13,fontWeight: FontWeight.w800),)),
                            SizedBox(
                              width: 28.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(ScreenTherapysession());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4,horizontal: 18),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),

                                ),
                                child: Text("Consultation",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
