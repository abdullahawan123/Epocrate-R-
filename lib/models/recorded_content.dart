class RecordedContent{
  String fileUrl,name,videoUrl;

//<editor-fold desc="Data Methods">
  RecordedContent({
    required this.fileUrl,
    required this.name,
    required this.videoUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordedContent &&
          runtimeType == other.runtimeType &&
          fileUrl == other.fileUrl &&
          name == other.name &&
          videoUrl == other.videoUrl);

  @override
  int get hashCode => fileUrl.hashCode ^ name.hashCode ^ videoUrl.hashCode;

  @override
  String toString() {
    return 'RecordedContent{' +
        ' fileUrl: $fileUrl,' +
        ' name: $name,' +
        ' videoUrl: $videoUrl,' +
        '}';
  }

  RecordedContent copyWith({
    String? fileUrl,
    String? name,
    String? videoUrl,
  }) {
    return RecordedContent(
      fileUrl: fileUrl ?? this.fileUrl,
      name: name ?? this.name,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fileUrl': this.fileUrl,
      'name': this.name,
      'videoUrl': this.videoUrl,
    };
  }

  factory RecordedContent.fromMap(Map<String, dynamic> map) {
    return RecordedContent(
      fileUrl: map['fileUrl'] as String,
      name: map['name'] as String,
      videoUrl: map['videoUrl'] as String,
    );
  }

//</editor-fold>
}