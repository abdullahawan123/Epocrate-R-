class Announcement{
  String  url,description,title;

//<editor-fold desc="Data Methods">
  Announcement({
    required this.url,
    required this.description,
    required this.title,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Announcement &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          description == other.description &&
          title == other.title);

  @override
  int get hashCode =>
      url.hashCode ^ description.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'LiveContent{' +
        ' url: $url,' +
        ' description: $description,' +
        ' meetingCode: $title,' +
        '}';
  }

  Announcement copyWith({
    String? url,
    String? description,
    String? meetingCode,
  }) {
    return Announcement(
      url: url ?? this.url,
      description: description ?? this.description,
      title: meetingCode ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'description': this.description,
      'meetingCode': this.title,
    };
  }


  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      url: map['url'] as String? ?? '', // Provide a default value or handle null case
      description: map['description'] as String? ?? '', // Provide a default value or handle null case
      title: map['meetingCode'] as String? ?? '', // Provide a default value or handle null case
    );
  }

//</editor-fold>
}
