import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:sizer/sizer.dart';

class ItemCoursesHome extends StatefulWidget {
  const ItemCoursesHome({Key? key}) : super(key: key);

  @override
  State<ItemCoursesHome> createState() => _ItemCoursesHomeState();
}

class _ItemCoursesHomeState extends State<ItemCoursesHome> {
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index ){
          return Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(20),
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
                Image.asset("assets/images/img_6.png"),
                SizedBox(
                  height: 1.h,
                ),
                Text("ABAT Supplementary Courses Lecture",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: Text("COURSE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),),
                    ),
                    PannableRatingBar(
                      rate: rating,
                      items: List.generate(1, (index) =>
                      const RatingWidget(
                        selectedColor: Colors.yellow,
                        unSelectedColor: Colors.grey,
                        child: Icon(
                          Icons.star,
                          size: 23,
                          textDirection: TextDirection.rtl,
                        ),
                      )),
                      onChanged: (value) { // the rating value is updated on tap or drag.
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                    Text("150 SAR",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.blue),),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Image.asset("assets/images/lineblue.png"),
              ],
            ),
          );
        });
  }
}
