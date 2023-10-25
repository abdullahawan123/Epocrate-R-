import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rushd/helpers/style.dart';
import 'package:rushd/view/screens/screen_login.dart';
import 'package:rushd/view/screens/screen_my_purchase.dart';
import 'package:rushd/view/screens/screen_personelinfo.dart';
import 'package:sizer/sizer.dart';
import 'package:rushd/models/user.dart' as model;
import '../../helpers/firebase_utils.dart';
import '../../helpers/helper.dart';

class ScreenEditProfile extends StatelessWidget {
  model.User user;
 ProfileController controller=Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 7.h,
          ),
      Container(
        alignment: Alignment.bottomRight,
        height: 100.sp,
        width: 100.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
          Border.all(color: Colors.grey, width: .4),
          image: DecorationImage(
              image:  NetworkImage(user.image.isEmpty?userPlaceHolder:user.image)),
        ),),
          SizedBox(
            height: 1.h,
          ),
          Text(user.userName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
          Container(
            child:Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                ListTile(
                  onTap: (){
                    Get.to(ScreenPersonelinfo(user:user));
                  },
                  leading: Icon(Icons.person,color: Colors.black,),
                  title: Text("Personal Info",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                ),
                // Divider(
                //   thickness: 1,
                //   color: Colors.black,
                // ),
                // ListTile(
                //   leading: Icon(Icons.video_library_outlined,color: Colors.black,),
                //   title: Text("My Courses",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                //   trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                // ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                ListTile(
                  onTap: (){
                    Get.to(ScreenMyPurchase());
                  },
                  leading: Icon(Icons.menu_book,color: Colors.black,),
                  title: Text("My Purchases",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                // ListTile(
                //   onTap: (){
                //
                //   },
                //   leading: Icon(Icons.food_bank_outlined,color: Colors.black,),
                //   title: Text("Bank Account info",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                //   trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                // ),
                // Divider(
                //   thickness: 1,
                //   color: Colors.black,
                // ),

                ListTile(
                  onTap: () async {
                   await  FirebaseAuth.instance.signOut().then((value) {
                     Get.offAll(ScreenLogin());
                   });
                  },
                  leading: Icon(Icons.logout,color: Colors.black,),
                  title: Text("LOGOUT",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ScreenEditProfile({
    required this.user,
  });
}
class ProfileController extends GetxController{
  var profile_image = File("").obs;
  RxBool ImageLoading = false.obs;

  Future<void> pickImageFromCamera(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageT = File(image.path);
    this.profile_image.value = imageT;
    ImageLoading.value = true;
    var newImage = await FirebaseUtils.uploadImage(
      profile_image.value.path,
      'images/${FirebaseUtils.myId}',
      onSuccess: (url) {
        // Handle successful upload here
        print('Image uploaded successfully. URL: $url');
      },
      onError: (error) {
        // Handle error during upload
        print('Error uploading image: $error');
      },
      onProgress: (progress) {
        // Handle upload progress
        print('Upload progress: $progress');
      },
    );
    await usersRef.doc(uid).update({"image": newImage});
    ImageLoading.value = false;
    profile_image.value = File("");
    update();
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4.4,
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Get.back();
            //         openSecondBottomSheet(context);
            //       },
            //       child: Container(
            //         alignment: Alignment.center,
            //         height: 55,
            //         width: 55,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.grey.withOpacity(.2),
            //               blurRadius: 25,
            //               spreadRadius: 4,
            //             ),
            //           ],
            //           shape: BoxShape.circle,
            //         ),
            //         child: Icon(
            //           Icons.access_time,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //     Text(
            //       "Recent\nPictures",
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         fontSize: 13,
            //         fontFamily: "Poppins",
            //         color: Color(0xff383838).withOpacity(.8),
            //       ),
            //     ),
            //   ],
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImageFromCamera(ImageSource.gallery);
                    Get.back();
                  }, // Call the image picker function on tap
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 25,
                          spreadRadius: 4,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "Select from\nGallery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    fontFamily: "Poppins",
                    color: Color(0xff383838).withOpacity(.8),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImageFromCamera(ImageSource.camera);
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 25,
                          spreadRadius: 4,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "Take from\ncamera",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    fontFamily: "Poppins",
                    color: Color(0xff383838).withOpacity(.8),
                  ),
                ),
              ],
            ),
          ]),
        );
      },
    );
  }
}