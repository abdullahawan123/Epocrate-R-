
class Message{
  String timeStamp;
  String senderId;
  String groupId;
  String text;
  String imageUrl;
  String userImage;

//<editor-fold desc="Data Methods">
  Message({
    required this.timeStamp,
    required this.senderId,
    required this.groupId,
    required this.text,
    required this.imageUrl,
    required this.userImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          runtimeType == other.runtimeType &&
          timeStamp == other.timeStamp &&
          senderId == other.senderId &&
          groupId == other.groupId &&
          text == other.text &&
          imageUrl == other.imageUrl &&
          userImage == other.userImage);

  @override
  int get hashCode =>
      timeStamp.hashCode ^
      senderId.hashCode ^
      groupId.hashCode ^
      text.hashCode ^
      imageUrl.hashCode ^
      userImage.hashCode;

  @override
  String toString() {
    return 'Message{' +
        ' timeStamp: $timeStamp,' +
        ' senderId: $senderId,' +
        ' groupId: $groupId,' +
        ' text: $text,' +
        ' imageUrl: $imageUrl,' +
        ' userImage: $userImage,' +
        '}';
  }

  Message copyWith({
    String? timeStamp,
    String? senderId,
    String? groupId,
    String? text,
    String? imageUrl,
    String? userImage,
  }) {
    return Message(
      timeStamp: timeStamp ?? this.timeStamp,
      senderId: senderId ?? this.senderId,
      groupId: groupId ?? this.groupId,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      userImage: userImage ?? this.userImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': this.timeStamp,
      'senderId': this.senderId,
      'groupId': this.groupId,
      'text': this.text,
      'imageUrl': this.imageUrl,
      'userImage': this.userImage,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      timeStamp: map['timeStamp'] as String,
      senderId: map['senderId'] as String,
      groupId: map['groupId'] as String,
      text: map['text'] as String,
      imageUrl: map['imageUrl'] as String,
      userImage: map['userImage'] as String,
    );
  }

//</editor-fold>
}