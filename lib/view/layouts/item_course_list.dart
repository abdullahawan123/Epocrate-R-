import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:open_file/open_file.dart';
import 'package:rushd/widgets/custom_listview_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

import '../../models/batch.dart';
import '../../models/batch_content.dart';
import '../screens/screen_class_video.dart';
import '../screens/screen_video_play.dart';

class ItemCourseList extends StatelessWidget {
  List<CourseContent> courseContents;
  Batch batch;

  @override
  Widget build(BuildContext context) {
    return (courseContents.isEmpty)?Center(child: Text("No Course Uploaded yet")):CustomListviewBuilder(
      itemCount: courseContents.length,
      scrollDirection: CustomDirection.vertical,
      itemBuilder: (BuildContext context, int index) {
        CourseContent courseContent = courseContents[index];
        return (courseContent.recordings != null)
            ? ListTile(
                onTap: () async {
                  // await OpenFile.open(courseContent.recordings!.videoUrl).catchError((error){
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No App To Open")));
                  // });
                  Get.to(LayoutOrientation(
                    recordedContent: courseContent.recordings!, batch: batch,
                  ));
                },
                leading: Icon(
                  Icons.play_circle_outline,
                  color: Color(0xff222448),
                ),
                title: Text(
                  courseContent.recordings!.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Image.asset(
                  "assets/images/img_19.png",
                  height: 6.h,
                  width: 12.w,
                ),
              )
            : (courseContent.assignmentContent != null)
                ? ListTile(
                    onTap: ()  async {

                      if (courseContent.assignmentContent!.fileType == "File") {
                        // Assuming you have stored the download link in 'courseContent.assignmentContent!.url'
                        String downloadLink = courseContent.assignmentContent!.url;

                        // Use the download link to download the file
                        firebase_storage.Reference ref =
                        firebase_storage.FirebaseStorage.instance.refFromURL(downloadLink);

                        final Directory appDocDir = await getApplicationDocumentsDirectory();
                        final File localFile = File('${appDocDir.path}/downloaded_file'); // Change the file name as needed

                        try {
                          await ref.writeToFile(localFile);
                          print('File downloaded and saved to: ${localFile.path}');
                          await OpenAppFile.open(localFile.path,)
                              .catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("No App To Open")));
                          });
                        } catch (e) {
                          print('Error downloading file: $e');
                        }
                      } else {
                        openZoomLink(courseContent.assignmentContent!.link);
                      }


                    },
                    leading: Icon(
                      Icons.assignment,
                      color: Color(0xff222448),
                    ),
                    title: Text(
                      courseContent.assignmentContent!.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(courseContent.assignmentContent!.link,maxLines: 1,),
                    trailing: Image.asset(
                      "assets/images/img_19.png",
                      height: 6.h,
                      width: 12.w,
                    ),
                  )
                : ListTile(
                    onTap: () {
                      openZoomLink(courseContent.announcement!.url);                    },
                    leading: Icon(
                      Icons.announcement,
                      color: Color(0xff222448),
                    ),
          subtitle: Text(courseContent.announcement!.url,style: TextStyle(color: Colors.blue),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    title: Text(
                      courseContent.announcement!.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Image.asset(
                      "assets/images/img_19.png",
                      height: 6.h,
                      width: 12.w,
                    ),
                  );
      },
    );
  }
  void openZoomLink(zoomLink) async {
    if (await canLaunch(zoomLink)) {
      await launch(zoomLink);
    } else {
      throw 'Could not launch Zoom link';
    }
  }
  Future<void> downloadAndSaveFile(fileUrl,fileName) async {
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child(fileUrl);
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final File localFile = File('${appDocDir.path}/$fileName');

    try {
      await ref.writeToFile(localFile);
      print('File downloaded and saved to: ${localFile.path}');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  ItemCourseList({
    required this.courseContents,
    required this.batch,
  });
}
