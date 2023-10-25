import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/controllers/registration_controller.dart';
import 'package:rushd/view/screens/screen__registration.dart';
import 'package:rushd/view/screens/screen_forget_password.dart';
import 'package:rushd/view/screens/screen_home.dart';
import 'package:rushd/view/screens/screen_welcome.dart';
import 'package:rushd/widgets/CustomPrograssIndicator.dart';
import 'package:rushd/widgets/my_custom_button.dart';
import 'package:sizer/sizer.dart';

class ScreenLogin extends StatelessWidget {
  RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return CustomProgressWidget(
            loading: controller.loginLoading.value,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(onPressed: () {
                              Get.back();
                            },
                                icon: Icon(Icons.arrow_back)),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Login", style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset(
                            "assets/images/img.png", height: 80, width: 70,),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text("Welcome Back !", style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),)),
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
                            suffixIcon: IconButton(
                                icon: Icon(Icons.visibility), onPressed: () {

                            }),
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
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                Get.to(ScreenForgetPassword());
                              },
                              child: Text("Forget Password ?"))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyCustomButton(text: "Sign In", onTap: () async {
                      var response = await controller.loginUser();
                      if (response == "success") {
                        Get.offAll(ScreenHome());
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response.toString())));
                      }
                    }, isRound: true, height: 41.sp,).marginSymmetric(
                        horizontal: 12.sp),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?"),
                        GestureDetector(
                            onTap: () {
                              Get.to(ScreenRegistration());
                            },
                            child: Text(" Sign Up", style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),)),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset("assets/images/img_3.png", width: 180,),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/img_3.png", width: 100,),
                        Text("or Login with"),
                        Image.asset("assets/images/img_3.png", width: 100,),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/images/img_4.png", height: 50, width: 50,),


                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
