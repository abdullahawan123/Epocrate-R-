import 'package:cloud_firestore/cloud_firestore.dart';

class ChatGroup {
  String id; // Group ID
  String eventId; // ID of the event associated with this chat group
  List<String> memberIds; // List of user IDs who joined the event and are part of this chat group

  ChatGroup({
    required this.id,
    required this.eventId,
    required this.memberIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'memberIds': memberIds,
    };
  }

  factory ChatGroup.fromSnapshot(DocumentSnapshot snapshot) {
    return ChatGroup(
      id: snapshot.id,
      eventId: snapshot['eventId'],
      memberIds: List.from(snapshot['memberIds']),
    );
  }

  factory ChatGroup.fromMap(Map<String, dynamic> map) {
    return ChatGroup(
      id: map['id'],
      eventId: map['eventId'],
      memberIds: List<String>.from(map['memberIds']),
    );
  }
}
