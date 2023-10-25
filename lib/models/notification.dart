class Notifications{
  String id;
  String eventId;
  String eventOwnerId;
  String joinUserId;
  String joinUserName;
  String joinUserImageUrl;
  bool read;

//<editor-fold desc="Data Methods">
  Notifications({
    required this.id,
    required this.eventId,
    required this.eventOwnerId,
    required this.joinUserId,
    required this.joinUserName,
    required this.joinUserImageUrl,
    required this.read,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notifications &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          eventId == other.eventId &&
          eventOwnerId == other.eventOwnerId &&
          joinUserId == other.joinUserId &&
          joinUserName == other.joinUserName &&
          joinUserImageUrl == other.joinUserImageUrl &&
          read == other.read);

  @override
  int get hashCode =>
      id.hashCode ^
      eventId.hashCode ^
      eventOwnerId.hashCode ^
      joinUserId.hashCode ^
      joinUserName.hashCode ^
      joinUserImageUrl.hashCode ^
      read.hashCode;

  @override
  String toString() {
    return 'Notifications{' +
        ' id: $id,' +
        ' eventId: $eventId,' +
        ' eventOwnerId: $eventOwnerId,' +
        ' joinUserId: $joinUserId,' +
        ' joinUserName: $joinUserName,' +
        ' joinUserImageUrl: $joinUserImageUrl,' +
        ' read: $read,' +
        '}';
  }

  Notifications copyWith({
    String? id,
    String? eventId,
    String? eventOwnerId,
    String? joinUserId,
    String? joinUserName,
    String? joinUserImageUrl,
    bool? read,
  }) {
    return Notifications(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      eventOwnerId: eventOwnerId ?? this.eventOwnerId,
      joinUserId: joinUserId ?? this.joinUserId,
      joinUserName: joinUserName ?? this.joinUserName,
      joinUserImageUrl: joinUserImageUrl ?? this.joinUserImageUrl,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'eventId': this.eventId,
      'eventOwnerId': this.eventOwnerId,
      'joinUserId': this.joinUserId,
      'joinUserName': this.joinUserName,
      'joinUserImageUrl': this.joinUserImageUrl,
      'read': this.read,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      id: map['id'] as String,
      eventId: map['eventId'] as String,
      eventOwnerId: map['eventOwnerId'] as String,
      joinUserId: map['joinUserId'] as String,
      joinUserName: map['joinUserName'] as String,
      joinUserImageUrl: map['joinUserImageUrl'] as String,
      read: map['read'] as bool,
    );
  }

//</editor-fold>
}