import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rushd/helpers/constants.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/chat_controller.dart';
import '../../helpers/firebase_utils.dart';
import '../../helpers/helper.dart';
import '../../models/chat_group.dart';
import '../../widgets/large_text.dart';
import '../../widgets/small_text.dart';
import '../layouts/item_message.dart';

class ScreenGroupChat extends StatefulWidget {
  final String event;
  final String expiry;

  ScreenGroupChat({required this.event, required this.expiry});

  @override
  State<ScreenGroupChat> createState() => _ScreenGroupChatState();
}

class _ScreenGroupChatState extends State<ScreenGroupChat> {
  ScrollController _scrollController = ScrollController();
  late Stream<DatabaseEvent> stream = Stream.empty();

  ChatController controller = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    controller.listenForMessages(widget.event);
    stream = chatGroupRef.child(widget.event).child('messages').onValue;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var todatDate =
        DateTime(now.day, now.month, now.year).millisecondsSinceEpoch;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
        centerTitle: true,
        title: LargeText(text: "Group Chat"),
        actions: [
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 13, horizontal: 7),
          //   child: GestureDetector(
          //     onTap: () {
          //       Get.to(ScreenReport(evetntId: widget.event,userId: "",));
          //     },
          //     child: SmallText(
          //       text: "Report",
          //       color: Colors.red,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: controller.getEventMembers(widget.event),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final eventMembers = snapshot.data;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(.1),
                          ),
                        ),
                        child: ListTile(
                          title: Text("Batch Group"),
                          subtitle: Text("${eventMembers!.length} Members"),
                          trailing: Container(
                            width: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: eventMembers.length,
                              itemBuilder: (BuildContext context, int index) {
                                final userData = eventMembers[index];
                                final String userAvatarUrl = userData?['image'];

                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        userAvatarUrl.isEmpty
                                            ? userPlaceHolder
                                            : userAvatarUrl.toString()),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<DatabaseEvent>(
                          key: ValueKey(widget.event),
                          stream: stream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            List<Message> messages = snapshot
                                .data!.snapshot.children
                                .map((e) => Message.fromMap(
                                    Map<String, dynamic>.from(
                                        e.value as dynamic)))
                                .toList();
                            messages.sort(
                                (b, a) => a.timeStamp.compareTo(b.timeStamp));

                            return messages.isNotEmpty
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    controller: _scrollController,
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      Message messageData = messages[index];
                                      String senderId = messageData.senderId;
                                      String message = messageData.text;
                                      String timestamp = messageData.groupId;
                                      String imageUrl = messageData.imageUrl;
                                      String userImage = messageData.userImage;

                                      return message.isNotEmpty
                                          ? BubbleSpecialOne(
                                              // senderId: senderId,
                                              text: message,
                                              // imageUrl: imageUrl,
                                              isSender: senderId == uid,
                                              profileImage:
                                                  userImage ?? userPlaceHolder,
                                            )
                                          : Align(
                                              alignment: senderId == uid
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                              child: Row(
                                                children: [
                                                  senderId == uid
                                                      ? SizedBox()
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(userImage ==
                                                                      null
                                                                  ? userPlaceHolder
                                                                  : userImage),
                                                        ),
                                                  Container(
                                                    padding: EdgeInsets.all(6),
                                                    margin: senderId == uid
                                                        ? EdgeInsets.only(
                                                            left: 20.w,
                                                            bottom: 5,
                                                            top: 4)
                                                        : EdgeInsets.only(
                                                            left: 12,
                                                            bottom: 5,
                                                            top: 4),
                                                    height: 25.h,
                                                    width: 68.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      border: Border.all(
                                                          width: .3,
                                                          color: Color(
                                                              0xffd6d6d6)),
                                                    ),
                                                    child: Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                    },
                                  )
                                : Center(
                                    child: Text("No message"),
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          widget.expiry == "ExpiryEvent"
              ? Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  // margin: EdgeInsets.symmetric(vertical: 1.h),
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                      color: appPrimaryColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12))),
                  child: Text(
                    "Event Expiry",
                    style: TextStyle(color: Colors.white),
                  ))
              : Obx(() {
                  return Container(
                    margin: EdgeInsets.only(left: 12, bottom: 5, right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(.1),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.chatController.value,
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  final imagePicker = ImagePicker();
                                  final pickedImage = await imagePicker
                                      .pickImage(source: ImageSource.gallery);
                                  if (pickedImage != null) {
                                    controller.image.value = pickedImage.path;
                                    // setState((){});
                                  }

                                  if (controller.image.value.isNotEmpty) {
                                    String imagePath = controller.image
                                        .value; // Get the image file path as a String

                                    int id =
                                        DateTime.now().millisecondsSinceEpoch;
                                    controller.uploadingLoading.value = true;

                                    try {
                                      controller.messageImageUrl.value =
                                          await FirebaseUtils.uploadImage(
                                        imagePath, // Pass the file path directly
                                        "messages/images/${id.toString()}",
                                        onSuccess: (url) {
                                          controller
                                              .sendMessage(
                                                  widget.event, "", url)
                                              .then((value) {
                                            controller.chatController.value
                                                .clear();
                                            controller.image.value = "";
                                          });
                                          controller.scrollToBottom();
                                          print(
                                              "Image uploaded successfully. URL: $url");
                                          controller.uploadingLoading.value =
                                              false;
                                          controller.scrollToBottom();
                                        },
                                        onError: (error) {
                                          print(
                                              "Error uploading image: $error");
                                          controller.uploadingLoading.value =
                                              false;
                                          // Handle the error here if needed.
                                        },
                                        onProgress: (progress) {
                                          print("Upload progress: $progress");
                                          // Update the progress if needed.
                                        },
                                      );

                                      controller.image.value = "";
                                    } catch (error) {
                                      print(
                                          "Error uploading image or sending message: $error");
                                      // Handle the error here if needed.
                                    }
                                  } else {
                                    print("Image file path is empty");
                                    // Handle the case where the image file path is empty.
                                  }
                                },
                                child: controller.uploadingLoading.value
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: .2,
                                          backgroundColor: Colors.red,
                                        ),
                                      )
                                    : Icon(Icons.link_off).paddingSymmetric(horizontal: 5)),
                            InkWell(
                              onTap: () async {
                                String message =
                                    controller.chatController.value.text.trim();

                                if (message.isNotEmpty) {
                                  controller
                                      .sendMessage(widget.event, message,
                                          controller.image.value)
                                      .then(
                                    (value) {
                                      controller.chatController.value.clear();
                                      controller.image.value = "";
                                    },
                                  );
                                }
                                controller.image.value = "";
                              },
                              child: Icon(Icons.send).paddingSymmetric(horizontal: 5),
                            ),
                          ],
                        ),
                        border: InputBorder.none,
                        hintText: "Write your message here",
                        hintStyle: TextStyle(
                          color: Color(0xffAAB2B7),
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  );
                })
        ],
      ),
    );
  }
}
