
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rushd/view/screens/screen_course_content.dart';
import 'package:sizer/sizer.dart';

class ScreenVideoPlay extends StatefulWidget {
  const ScreenVideoPlay({Key? key}) : super(key: key);

  @override
  State<ScreenVideoPlay> createState() => _ScreenVideoPlayState();
}

class _ScreenVideoPlayState extends State<ScreenVideoPlay> {
  @override
  Widget build(BuildContext context) {
    // late FlickManager flickManager;
    // @override
    // void initState() {
    //   super.initState();
    //   flickManager = FlickManager(
    //     videoPlayerController:
    //     VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
    //   );
    // }
    //
    // @override
    // void dispose() {
    //   flickManager.dispose();
    //   super.dispose();
    // }
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xff222448),

              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(onPressed: () {
                      Get.back();
                    },
                        icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text("ABAT Supplementary Courses Lecture",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
                  SizedBox(
                    height: 6.h,
                  ),
                ],
              ),
            ),
            // Container(
            //
            //   child: FlickVideoPlayer(
            //       flickManager: flickManager
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
