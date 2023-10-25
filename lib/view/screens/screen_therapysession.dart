import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/view/layouts/item_sessions.dart';
import 'package:rushd/view/layouts/layout_Home.dart';
import 'package:sizer/sizer.dart';



class ScreenTherapysession extends StatefulWidget {
  const ScreenTherapysession({Key? key}) : super(key: key);

  @override
  State<ScreenTherapysession> createState() => _ScreenTherapysessionState();
}

class _ScreenTherapysessionState extends State<ScreenTherapysession> {

  final List<String> items = [
    'Family and myself counseling',
    'One-to-One Learning Sessions',
    'Pronunciation and Communication SLP',
    'ABA Applied Behavior Analysis',
    'Occupational Therapy OP',
    'Consulting',
    'Evaluation',
  ];
  String? selectedValue;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed: () {
          Get.back();
        },)
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Container(
                alignment: Alignment.centerRight,
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/img_10.png"),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.grey, // Set the border color
                    width: 0.8, // Set the border width
                  ),
                  borderRadius: BorderRadius.circular(8), // Set the border radius
                ),
              ),
            ),


            Text("   Book a treatment session",style: TextStyle(color: Colors.black,fontSize: 24, fontWeight: FontWeight.w400,)),

            Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the text to the right
              children: [
                SizedBox(
                  width: 1.h,
                ),
                Text(" Therapy sessions",style: TextStyle(color: Colors.blueGrey,fontSize: 14, fontWeight: FontWeight.w300,)),
                SizedBox(
                  width: 3.h,
                ),
                Text( "150 SAR", style: TextStyle( color: Color(0xff0E599E), fontSize: 19, fontWeight: FontWeight.w600,)),
                SizedBox(
                  width: 1.h,
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("About ",style: TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: .5.h,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("After you choose the type of service, you will be linked to a suitable specialist in the field",style: TextStyle(color:Colors.black,fontSize:15)),
            ),


            SizedBox(
              height: .5.h,
            ),

            Row (
                children: [
                  Text(" * ",style: TextStyle(color: Colors.red,fontSize: 16, fontWeight: FontWeight.w700,)),
                  Text(" Session Type",style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500,)),
                ]
            ),

            SizedBox(
              height: 2.h,
            ),


            Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          'Choose',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ],
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                    },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: 300,
                    padding: const EdgeInsets.only(left: 10, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.8,
                      ),
                      color: Colors.white,
                    ),
                    elevation: 0,
                  ),

                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 200,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    elevation: 8,
                    offset: const Offset(25, -2),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
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
                  padding: EdgeInsets.symmetric(horizontal: 34.w,vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Color(0xff222448),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                ),
              ),
            ),
]
                ),
      ),
    );

  }
}


