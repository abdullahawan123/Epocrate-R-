class LastMessage{
  String? id;
  String? eventId;
  String? message;

//<editor-fold desc="Data Methods">
  LastMessage({
    this.id,
    this.eventId,
    this.message,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          eventId == other.eventId &&
          message == other.message);

  @override
  int get hashCode => id.hashCode ^ eventId.hashCode ^ message.hashCode;

  @override
  String toString() {
    return 'LastMessage{' +
        ' id: $id,' +
        ' eventId: $eventId,' +
        ' message: $message,' +
        '}';
  }

  LastMessage copyWith({
    String? id,
    String? eventId,
    String? message,
  }) {
    return LastMessage(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'eventId': this.eventId,
      'message': this.message,
    };
  }

  factory LastMessage.fromMap(Map<String, dynamic> map) {
    return LastMessage(
      id: map['id'] as String,
      eventId: map['eventId'] as String,
      message: map['message'] as String,
    );
  }

//</editor-fold>
}