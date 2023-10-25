import 'dart:convert';
import 'assignment_content.dart';
import 'live_content.dart';
import 'recorded_content.dart';

class CourseContent {
  String sessionName, sessionId, contentType, batchId;
  RecordedContent? recordings;
  AssignmentContent? assignmentContent;
  Announcement? announcement;

  //<editor-fold desc="Data Methods">
  CourseContent({
    required this.sessionName,
    required this.sessionId,
    required this.contentType,
    required this.batchId,
    required this.recordings,
     this.assignmentContent,
    this.announcement,
  });

  Map<String, dynamic> toMap() {
    return {
      'sessionName': sessionName,
      'sessionId': sessionId,
      'contentType': contentType,
      'batchId': batchId,
      'recordings': recordings?.toMap(),
      'assignmentContent': assignmentContent?.toMap(),
      'liveContent': announcement?.toMap(),
    };
  }

  factory CourseContent.fromMap(Map<String, dynamic> map) {
    return CourseContent(
      sessionName: map['sessionName'] as String,
      sessionId: map['sessionId'] as String,
      contentType: map['contentType'] as String,
      batchId: map['batchId'] as String,
      recordings: map['recordings'] != null
          ? RecordedContent.fromMap(map['recordings'])
          : null,
      announcement: map['liveContent'] != null
          ? Announcement.fromMap(map['liveContent'])
          : null,
      assignmentContent: map['assignmentContent'] != null
          ? AssignmentContent.fromMap(map['assignmentContent'])
          : null,
    );
  }
//</editor-fold>
}
