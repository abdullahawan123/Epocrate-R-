import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helpers/fcm.dart';
import '../helpers/helper.dart';
import '../models/chat_group.dart';
import '../models/last_message.dart';
import '../models/notification.dart';
import '../view/screens/screen_event_group.dart';
// import '../models/last_message.dart';
// import '../views/screens/screen_group_chat.dart';

class ChatController extends GetxController{
  ScrollController scrollController = ScrollController();
  Rx<TextEditingController> chatController = TextEditingController().obs;

  final DatabaseReference chatGroupRef = FirebaseDatabase.instance.reference().child("GroupChat");
  List<Map<String, dynamic>> messages = [];
  RxList<String> imagesUrl = RxList<String>([]);

  RxString messageImageUrl = "".obs;
  RxString image = "".obs;
  RxBool uploadingLoading = false.obs;

  void listenForMessages(event_Id) {
    getMessages(event_Id).asyncMap((List<Map<String, dynamic>> newMessages) {
      return newMessages;
    }).listen((newMessages) {
      messages.clear(); // Clear the existing messages list
      messages.addAll(newMessages);
      messages.sort((a, b) => a['timeStamp'].compareTo(b['timeStamp'])); // Sort the messages
      scrollToBottom();
      update();
    });
  }
  // void _scrollToBottom() {
  //   if (scrollController.hasClients) {
  //     scrollController.animateTo(
  //       scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   }
  // }
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }


  Stream<List<Map<String, dynamic>>> getUsersByIds(List<String> userIds) {
    return Stream.periodic(Duration(seconds: 5)).asyncMap((_) async {
      List<Map<String, dynamic>> usersData = [];

      for (String userId in userIds) {
        final DocumentSnapshot userSnapshot = await usersRef.doc(userId).get();
        if (userSnapshot.exists) {
          usersData.add(userSnapshot.data() as Map<String, dynamic>);
        }
      }

      return usersData;
    });
  }  // void listenForMessages(String eventId) {
  //   getMessages(eventId).listen((List<Map<String, dynamic>> newMessages) {
  //
  //     messages = newMessages;
  //
  //     scrollToBottom(); // Scroll to the bottom whenever new messages are received
  //
  //   });
  // }




  Future<void> sendMessage(String groupId, String messageText,String? ImageUrl) async {
    int id = DateTime.now().millisecondsSinceEpoch;

    try {
      String senderId = FirebaseAuth.instance.currentUser!.uid;
      var imageUrl= await getCurrentUserImage(uid);
      Message message = Message(
        timeStamp: id.toString(),
        senderId: senderId,
        groupId: groupId,
        text: messageText.toString(),
        imageUrl: ImageUrl!,
        userImage: imageUrl!,
      );
      Map<String, dynamic> messageData = message.toMap(); // Convert Message object to Map

      // Map<String, dynamic> messageData = {
      //   'senderId': senderId,
      //   'message': message,
      //   'timestamp': ServerValue.timestamp,
      // };

      await chatGroupRef.child(groupId).child('messages').push().set(messageData);
      await usersRef.doc(uid).collection("lastMessage").doc(groupId).set(
          {"id" : id.toString(),"message" :messageText.toString(), "eventId" : groupId});

      print("Message sent successfully.");
    } catch (error) {
      print("Error sending message: $error");
    }
  }


  Stream<List<Map<String, dynamic>>> getMessages(String groupId) {
    return chatGroupRef
        .child(groupId)
        .child('messages')
        .onValue
        .asyncMap((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> messagesData = json.decode(
            json.encode(event.snapshot.value));
        List<Map<String, dynamic>> messages = [];

        messagesData.forEach((key, value) {
          messages.add(Message.fromMap(value).toMap());
        });

        return messages;
      } else {
        return [];
      }
    });
  }

  Future<List<Map<String, dynamic>>> getEventMembers(String eventId) async {
    final DocumentSnapshot groupChatSnapshot = await groupChatRef.doc(eventId)
        .get();
    if (groupChatSnapshot.exists) {
      final groupChatData = groupChatSnapshot.data() as Map<String,
          dynamic>; // Explicit cast
      final List<String> memberIds = List<String>.from(
          groupChatData['memberIds'] ?? []);

      List<Map<String, dynamic>> eventMembers = [];

      for (String memberId in memberIds) {
        final DocumentSnapshot userSnapshot = await usersRef.doc(memberId)
            .get();
        if (userSnapshot.exists) {
          eventMembers.add(userSnapshot.data() as Map<String, dynamic>);
        }
      }

      return eventMembers;
    }

    return [];
  }

  Future<String?> getCurrentUserImage(uid) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        DocumentSnapshot userSnapshot = await usersRef.doc(uid).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
          return userData['image'] as String?;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting current user name: $e');
      return null;
    }
  }
  RxBool checking=false.obs;

  Future<void> joinGroup(String groupId) async {
    int id = DateTime.now().millisecondsSinceEpoch;
    try {
      checking.value=true;
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // First, get the existing chat group data
      DocumentSnapshot groupSnapshot = await groupChatRef.doc(groupId).get();
      if (groupSnapshot.exists) {
        List<String> memberIds = List.from(groupSnapshot['memberIds']);
        if (!memberIds.contains(userId)) {
          memberIds.add(userId);
          // Update the memberIds in the chat group document
          await groupChatRef.doc(groupId).update({'memberIds': memberIds}).then((value) async {
            LastMessage lastMessages =
            LastMessage(id: id.toString(), eventId: groupId, message: "");
            await usersRef
                .doc(uid)
                .collection("lastMessage")
                .doc(groupId)
                .set(lastMessages.toMap());
          });
          await chatGroupRef.child(groupId).update({'memberIds': memberIds}).then((value) async {
            DocumentSnapshot eventSnapshot = await batchesRef.doc(groupId).get();
            String ownerId = eventSnapshot['id'];
            if (!eventSnapshot.exists) {
              print("Event not found.");

              checking.value=false;
              return;
            }
            DocumentSnapshot ownerData = await usersRef.doc(ownerId).get();
            String owenrNotificationtoken = ownerData['notificationToken'];
            DocumentSnapshot joinUser = await usersRef.doc(uid).get();
            if (joinUser.exists) {
              String joinUserName = joinUser['name'];
              String joinUserimageUrl = joinUser['image'];
              String eventDesc = joinUser['description'];

              // Construct notification title and body
              String notificationTitle = "New Member Joined Your Event";
              String notificationBody =
                  "$joinUserName, a new member, has joined your event: $eventDesc";

              // Send notification to the event owner using your notification service (FCM)
              FCM.sendMessageSingle(notificationTitle, notificationBody,
                  owenrNotificationtoken, {},isWeb: true).then((value) async {
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                Notifications notification = Notifications(
                    id: id,
                    eventId: groupId,
                    eventOwnerId: ownerId,
                    joinUserId: uid,
                    joinUserName: joinUserName,
                    joinUserImageUrl: joinUserimageUrl,
                    read: false);
                await notificatontRef
                    .doc(id.toString())
                    .set(notification.toMap())
                    .catchError((onError) {
                  print("NotificationError ${onError.toString()}");
                });
              }).catchError((onError) {

                checking.value=false;
                print("NotificationError FCM ${onError.toString()}");
              });
            }
            Get.snackbar("Successfully", "Join group");

            Get.to(ScreenGroupChat(
              event: groupId,
              expiry: 'Active',
            ));
          });

          checking.value=false;

          print("User joined the group.");
        }
        else {

          checking.value=false;
          print("User is already a member of the group.");
          // Get.snackbar("Alert", "User is already a member of the group.");
          Get.to(ScreenGroupChat(
            event: groupId,
            expiry: 'Active',
          ));
        }

      }
    } catch (error) {

      checking.value=false;
      print("Error joining group: $error");
      joinGroup(groupId);
    }
  }


}