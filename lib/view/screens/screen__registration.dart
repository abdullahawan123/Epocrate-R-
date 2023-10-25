import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/controllers/registration_controller.dart';
import 'package:rushd/view/screens/screen_home.dart';
import 'package:rushd/view/screens/screen_login.dart';
import 'package:rushd/view/screens/screen_verification.dart';
import 'package:rushd/widgets/CustomPrograssIndicator.dart';
import 'package:rushd/widgets/my_custom_button.dart';
import 'package:sizer/sizer.dart';

class ScreenRegistration extends StatelessWidget {
  RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: () {
            Get.back();
          },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
          title: Text("Create an Account", style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 18, color: Colors.black),),

        ),
        body: Obx(() {
          return CustomProgressWidget(
            loading: controller.signUpLoading.value,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  // Stack(
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.blue,
                  //       ),
                  //
                  //       child: Image.asset("assets/images/img_1.png",
                  //         height: 120, width: 150,),
                  //     ),
                  //     Positioned(
                  //         right: 5,
                  //         bottom: 0,
                  //         child: Image.asset("assets/images/img_2.png",
                  //           height: 50, width: 30,)),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: controller.nameController,
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
                      controller: controller.userNameController,
                      decoration: InputDecoration(
                          hintText: "User Name",
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
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate.value ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          controller.selectedDate.value = pickedDate;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Date of Birth",
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.22),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: TextEditingController(
                        text: controller.selectedDate.value != null
                            ? "${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}"
                            : "",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
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
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
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
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "Phone number",
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
                    child: DropdownButtonFormField<String>(
                      icon:  Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                      decoration: InputDecoration(

                        hintText: "Gender",
                        // suffixIcon: Icon(
                        //   Icons.arrow_drop_down,
                        //   color: Colors.blue,
                        // ),
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.22),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      value: controller.gender.value,
                      items: ["Male", "Female", "Other"]
                          .map<DropdownMenuItem<String>>(
                            (String value) =>
                            DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                      )
                          .toList(),
                      onChanged: (value) {
                        controller.gender.value = value!;
                      },
                    ),
                  ),
                  MyCustomButton(text: "Sign Up",
                    onTap: () async{
                    var response=await controller.registerUser();
                    if (response=="success") {
                      Get.offAll(ScreenHome());
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.toString())));
                    }
                    },
                    isRound: true,
                    height: 41.sp,).marginSymmetric(horizontal: 12.sp),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: Get.width,
                    height: 38.sp,
                    margin: EdgeInsets.symmetric(horizontal: 5.w,),
                    child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding:
                            EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.5.h)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset("assets/images/google.png"),

                            Text(
                              "Sign in with Google",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(width: 10,),
                          ],
                        )),
                  ),


                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),),
                      GestureDetector(
                          onTap: () {
                            Get.to(ScreenLogin());
                          },
                          child: Text("Sign in", style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),))
                    ],

                  ).marginSymmetric(vertical: 12.sp),


                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
