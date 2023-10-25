import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rushd/models/user.dart' as model;

import '../helpers/helper.dart';
import '../view/screens/screen_home.dart';

class RegistrationController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();

  // bool passenable = true;
  // int value = 0;
  RxBool loginLoading = false.obs;
  RxBool forgetLoading = false.obs;
  RxBool signUpLoading = false.obs;
  RxString gender = "Male".obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<String> loginUser() async {
    String response = "";
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty || password.isNotEmpty) {
      loginLoading.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        // if (value.user!.emailVerified) {
        //   var user = await getUserById(value.user!.uid);
        //   if (user.type == "user") {
        //     Get.offAll(ScreenHome());
        //   }
        //   else {
        //     Get.snackbar("Alert", "No User");
        //   }
        // } else {
        //   Get.defaultDialog(
        //       title: "Email not Verified",
        //       content: Text("Please check and verify your Email"),
        //       actions: [
        //         OutlinedButton(onPressed: () {
        //           value.user!.sendEmailVerification();
        //           Get.back();
        //         }, child: Text("Resend Email")),
        //         OutlinedButton(onPressed: () {
        //           Get.back();
        //         }, child: Text("Dismiss"))
        //       ]
        //   );
        // }
        response = "success";

        loginLoading.value = false;
      }).catchError((error) {
        loginLoading.value = false;
        response = error.toString();
      });
    } else {
      response = "Email and Password is required";
    }
    return response;
  }

  Future<String> registerUser() async {
    String response = "";
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String phone = phoneController.text;
    String userName = userNameController.text;
    signUpLoading.value = true;
    if (email.isNotEmpty || name.isNotEmpty || password.isNotEmpty) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) async {
        print("User Register Successfully");
        print(userCredential);
        var uid = userCredential.user!.uid;
        model.User user = model.User(
          id: uid,
          documents: "",
          type: "user",
          gender: gender.value,
          phone: phone,
          name: name,
          userName: userName,
          email: email,
          password: password,
          notificationToken: "",
          timeStamp: DateTime.now().microsecondsSinceEpoch,
          image: "",
          dob: selectedDate.value.millisecondsSinceEpoch,
          blocked: false,
        );
        await usersRef.doc(uid).set(user.toMap()).then((value) {
          // userCredential.user!.sendEmailVerification();
          // Get.snackbar("Alert", "Email Verification Has been Send Please Verify Your Email ", duration: Duration(seconds: 3));
          response = "success";
          signUpLoading.value = false;
        }).catchError((error) {
          response = error.toString();
          signUpLoading.value = false;
        });
      }).catchError((error) {
        response = error.toString();
        signUpLoading.value = false;
      });
    } else {
      response = "All Fields Required";
      signUpLoading.value = false;
    }

    return response;
  }

  Future<void> ForgetPassword() async {
    forgetLoading.value = true;
    String email = emailController.text;
    if (email.isNotEmpty) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        forgetLoading.value = false;

        Get.snackbar(
            "Reset Password", "Reset Password email sent Successfully");
      }).catchError((error) {
        forgetLoading.value = false;

        Get.snackbar("Alert", error.toString());
      });
    } else {
      forgetLoading.value = false;
      Get.snackbar("Alert", "Please Enter Email");
    }
  }

  ///Validation Functions
  final formKeyLogIn = GlobalKey<FormState>().obs;
  final formKeySignUp = GlobalKey<FormState>().obs;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
