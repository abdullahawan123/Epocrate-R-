import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/controllers/chat_controller.dart';
import 'package:rushd/helpers/firebase_utils.dart';
import 'package:rushd/helpers/helper.dart';
import 'package:rushd/models/batch.dart';
import 'package:rushd/view/screens/screen_courses.dart';
import 'package:rushd/widgets/CustomPrograssIndicator.dart';
import 'package:sizer/sizer.dart';
import 'package:rushd/models/user.dart' as model;

import '../../controllers/controller_payments.dart';
import '../../helpers/fcm.dart';
import '../../models/last_message.dart';
import '../../models/notification.dart';
import '../../models/payment.dart';
import '../screens/screen_event_group.dart';

class ItemCourseRegistration extends StatelessWidget {
  Batch batch;
  RxBool loading = false.obs;
  final Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedFile.value = result.files.first;
    }
  }

  ChatController controller=Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: usersRef.doc(uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.none) {
                return Text('Error: ${snapshot.error}');
              }
              model.User user = model.User.fromMap(
                  snapshot.data!.data() as Map<String, dynamic>);
              return Obx(() {
                return CustomProgressWidget(
                  loading: loading.value,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            color: Color(0xff222448),

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(onPressed: () {
                                  Get.back();
                                },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,)),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                batch.name, style: TextStyle(color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),),
                              SizedBox(
                                height: 2.h,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                  child: Text("Course", style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Registration form", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),),

                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                      text: user.name),
                                  decoration: InputDecoration(
                                      hintText: "Full name",

                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1
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
                                  controller: TextEditingController(
                                      text: user.email),
                                  decoration: InputDecoration(
                                      hintText: "Email address",
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1
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
                                  controller: TextEditingController(
                                      text: user.phone),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "Mobile Number",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1
                                        ),
                                        borderRadius: BorderRadius.circular(12)
                                    ),

                                  ),
                                ),
                              ),
                              Text(
                                  "* 40 Hours RBT Certificate (Expiry Date General)"),
                              (user.documents.isNotEmpty)?Text("Documents Already Exist "):Obx(() {
                                return GestureDetector(
                                  onTap: pickFile,
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.h, horizontal: 35.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.black
                                        )

                                    ),
                                    child: (selectedFile.value == null) ? Text(
                                      "Upload File", style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),) : Text(
                                        selectedFile.value!.name),
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () async {
                                      loading.value=true;
                                      if (selectedFile.value!=null) {
                                        var url=await FirebaseUtils.uploadImage(selectedFile.value!.path.toString(), "User/$uid/document/${FirebaseUtils.myId}${selectedFile.value!.extension}").catchError((error){
                                          loading.value=false;

                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                                        });
                                        await usersRef.doc(uid).update({
                                          "documents":url
                                        }).catchError((error){
                                          loading.value=false;
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                                        });
                                      }
                                      await PaymentsController().makePayment(
                                        batch.price,
                                        "NOK",
                                        "NO",
                                        appName,
                                        onSuccess: (infoData) async {
                                          log("On success");
                                          Payment payment = Payment(
                                            id: FirebaseUtils.newId.toString(),
                                            user_id: FirebaseUtils.myId,
                                            batch_id: batch.id,
                                            amount:  batch.price,
                                            paymentInfo: infoData,
                                          );
                                          await paymentRef.doc(payment.id).set(payment.toMap());
                                          await batchesRef.doc(batch.id).collection("Students").doc(uid).set(user.toMap());
                                          loading.value=false;
                                          Get.find<ChatController>().joinGroup(batch.id);

                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Register to ${batch.name}")));

                                        },
                                        onError: (error) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                                          loading.value=false;
                                        },
                                        feePercent: 0,
                                      );


                                    // onTap: ()async{
                                    //   var status = await PaymentsController()
                                    //       .makePayment(batch.price, "NOK", "NO", "user Name",
                                    //       onSuccess: (infoData) {
                                    //         print(infoData);
                                    //       }, onError: (error) {}, feePercent: 2);
                                    //   if (status != "success") {
                                    //     loading.value=false;
                                    //     // response="Payment Issue";
                                    //   }
                                    // },}
                                  }, child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 23.w, vertical: 1.2.h),
                                    decoration: BoxDecoration(
                                      color: Color(0xff222448),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Text("Continue", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            }
        ),
      ),
    );
  }

  ItemCourseRegistration({
    required this.batch,
  });

}
