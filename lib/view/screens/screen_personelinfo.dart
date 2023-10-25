import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rushd/view/screens/screen_edit_profile.dart';
import 'package:sizer/sizer.dart';
import 'package:rushd/models/user.dart' as model;

import '../../helpers/helper.dart';
import '../../helpers/style.dart';

class ScreenPersonelinfo extends StatelessWidget {
  model.User user;
  ProfileController controller = Get.put(ProfileController());
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => controller.openBottomSheet(context),
                  // Open bottom sheet on tap
                  child: Obx(() {
                    return controller.ImageLoading.value
                        ? Container(
                            height: 100.sp,
                            width: 100.sp,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              backgroundColor: Colors.red,
                            ),
                          )
                        : Container(
                            alignment: Alignment.bottomRight,
                            height: 100.sp,
                            width: 100.sp,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: .4),
                              image: DecorationImage(
                                  image: (controller.profile_image.value == "")
                                      ? NetworkImage(user.image)
                                      : FileImage(File(controller.profile_image
                                          .value.path)) as ImageProvider),
                            ),
                            child: Image.asset(
                              "assets/images/img_2.png",
                              height: 50,
                              width: 30,
                            ),
                          );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _fullNameController..text=user.name,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.22),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _userNameController..text=user.userName,
                  decoration: InputDecoration(
                    hintText: "User Name",
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.22),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(12),
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
                  onTap: () async {
                    final updatedData = {
                      'name': _fullNameController.text,
                      'userName': _userNameController.text,
                    };
                  await  usersRef.doc(uid).update(updatedData).then((value) {
                    Get.back();
                  });
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 35.w, vertical: 1.5.h),
                    decoration: BoxDecoration(
                      color: Color(0xff222448),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ScreenPersonelinfo({
    required this.user,
  });
}
