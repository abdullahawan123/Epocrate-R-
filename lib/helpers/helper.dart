import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:rushd/view/screens/screen_home.dart';
import 'package:rushd/view/screens/screen_login.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:rushd/models/user.dart' as model;
var dbInstance = FirebaseFirestore.instance;
CollectionReference usersRef = dbInstance.collection("users");
CollectionReference categoriesRef = dbInstance.collection("courses");
CollectionReference postsRef = dbInstance.collection("posts");
CollectionReference postsRefAns = postsRef.doc().collection('ansPosts');
String placeholder_url =
    "https://phito.be/wp-content/uploads/2020/01/placeholder.png";
String userPlaceHolder =
    "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png";
String appName = "Rushd";
Color textColor = Color(0xFF222448);
CollectionReference batchesRef = dbInstance.collection("batches");
CollectionReference paymentRef = dbInstance.collection("payments");
var currencyCode = "PKR";
CollectionReference notificatontRef = dbInstance.collection("notifications");

var chatGroupRef = FirebaseDatabase.instance.ref("GroupChat/");
CollectionReference groupChatRef = dbInstance.collection("GroupChats");
var uid = FirebaseAuth.instance.currentUser!.uid;

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

// Future<void> launchUrl(String url) async {
//   url = !url.startsWith("http") ? ("http://" + url) : url;
//   if (await canLaunch(url)) {
//     launch(
//       url,
//       forceSafariVC: true,
//       enableJavaScript: true,
//       forceWebView: GetPlatform.isAndroid,
//     );
//   } else {
//     throw 'Could not launch $url';
//   }
// }

Map<String, model.User> allUsersMap = {};
//
Future<model.User> getUserById(String id) async {
  model.User? user = allUsersMap[id];
  if (user != null) {
    return user;
  }
  var doc = await usersRef.doc(id).get();
  if (!doc.exists) {
    return defaultUser;
  }
  user = model.User.fromMap(doc.data() as Map<String, dynamic>);
  return user;
}
void navigateToMainScreen() {
  Timer(Duration(seconds: 2), () async {
    if (auth.FirebaseAuth.instance.currentUser != null) {
      var uid = auth.FirebaseAuth.instance.currentUser!.uid;
      var user = await getUserById(uid);
      Get.offAll(ScreenHome());
      // if (user.userType == "admin") {
      //   Get.offAll(ScreenDashboard());
      // } else {
      //   Get.offAll(ScreenHome());
      // }
    }
    else {
      Get.offAll(ScreenLogin());
    }
  });
}

model.User defaultUser = model.User(
    id: "",
    blocked: false,
    type: "user",
    image: userPlaceHolder,
    gender: "",
    dob: 1,
    userName: "test",
    timeStamp: 1,
    password: "",
    name: "Test user",
    phone: "",
    documents: "",
    email: "",
    notificationToken: "",
    );
