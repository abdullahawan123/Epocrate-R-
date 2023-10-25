class AssignmentContent{
  String title,url,link,fileType,linkType;

//<editor-fold desc="Data Methods">
  AssignmentContent({
    required this.title,
    required this.url,
    required this.link,
    required this.fileType,
    required this.linkType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssignmentContent &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          url == other.url &&
          link == other.link &&
          fileType == other.fileType &&
          linkType == other.linkType);

  @override
  int get hashCode =>
      title.hashCode ^
      url.hashCode ^
      link.hashCode ^
      fileType.hashCode ^
      linkType.hashCode;

  @override
  String toString() {
    return 'AssignmentContent{' +
        ' title: $title,' +
        ' url: $url,' +
        ' link: $link,' +
        ' fileType: $fileType,' +
        ' linkType: $linkType,' +
        '}';
  }

  AssignmentContent copyWith({
    String? title,
    String? url,
    String? link,
    String? fileType,
    String? linkType,
  }) {
    return AssignmentContent(
      title: title ?? this.title,
      url: url ?? this.url,
      link: link ?? this.link,
      fileType: fileType ?? this.fileType,
      linkType: linkType ?? this.linkType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'url': this.url,
      'link': this.link,
      'fileType': this.fileType,
      'linkType': this.linkType,
    };
  }

  factory AssignmentContent.fromMap(Map<String, dynamic> map) {
    return AssignmentContent(
      title: map['title'] as String,
      url: map['url'] as String,
      link: map['link'] as String,
      fileType: map['fileType'] as String,
      linkType: map['linkType'] as String,
    );
  }

//</editor-fold>
}
class FileUrl{
  String url,type;

//<editor-fold desc="Data Methods">
  FileUrl({
    required this.url,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileUrl &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          type == other.type);

  @override
  int get hashCode => url.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'FileUrl{' + ' url: $url,' + ' type: $type,' + '}';
  }

  FileUrl copyWith({
    String? url,
    String? type,
  }) {
    return FileUrl(
      url: url ?? this.url,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'type': this.type,
    };
  }

  factory FileUrl.fromMap(Map<String, dynamic> map) {
    return FileUrl(
      url: map['url'] as String,
      type: map['type'] as String,
    );
  }

//</editor-fold>
}
