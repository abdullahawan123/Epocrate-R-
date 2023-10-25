import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/helpers/firebase_utils.dart';
import 'package:rushd/helpers/helper.dart';
import 'package:rushd/models/user.dart' as model;
import 'package:sizer/sizer.dart';

import '../screens/screen_edit_profile.dart';
import 'layout_Home.dart';

class LayoutProfile extends StatelessWidget {
  const LayoutProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: usersRef.doc(FirebaseUtils.myId).snapshots(),
          builder: (BuildContext context,  snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError||snapshot.connectionState==ConnectionState.none) {
              return Text('Error: ${snapshot.error}');
            }
            model.User user=model.User.fromMap(snapshot.data!.data() as Map<String,dynamic>);
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 30.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xff22244A),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),

                  )
                ),
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.image.isNotEmpty?user.image:userPlaceHolder),
                    ),
                  ),
                  title: Text(user.name,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
                  subtitle: Text(user.userName,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
                  trailing: Column(
                    children: [
                      Image.asset("assets/images/img_18.png", height: 3.h, width: 12.w,),
                      Text("2000" ,style: TextStyle(color: Color(0xffA342AE)),)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    ListTile(
                      onTap: (){
                        Get.to(ScreenEditProfile(user: user,));
                      },
                      leading: Icon(Icons.person,color: Colors.black,),
                      title: Text("Edit Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    ListTile(
                      leading: Icon(Icons.notification_add,color: Colors.black,),
                      title: Text("Notifications",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                    ),
                    // Divider(
                    //   thickness: 1,
                    //   color: Colors.black,
                    // ),
                    // ListTile(
                    //   leading: Icon(Icons.menu_book,color: Colors.black,),
                    //   title: Text("My Shelf",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                    //   trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                    // ),
                    // Divider(
                    //   thickness: 1,
                    //   color: Colors.black,
                    // ),
                    // ListTile(
                    //   leading: Icon(Icons.calendar_month,color: Colors.black,),
                    //   title: Text("Calender",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                    //   trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                    // ),

                    Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.support_agent,color: Colors.black,),
                title: Text("Help & Support",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
              ),

            ],
          );
        }
      )
    );
  }
}
