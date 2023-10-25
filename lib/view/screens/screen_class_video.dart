import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:rushd/models/recorded_content.dart';
import 'package:rushd/view/screens/screen_event_group.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

import '../../models/batch.dart';
class LayoutOrientation extends StatefulWidget {
  RecordedContent recordedContent;
  Batch batch;
  @override
  _LayoutOrientationState createState() => _LayoutOrientationState();

  LayoutOrientation({
    required this.recordedContent,
    required this.batch,
  });
}

class _LayoutOrientationState extends State<LayoutOrientation> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  double _volume = 1.0;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.recordedContent.videoUrl
    )..initialize().then((_) {
      setState(() {});
    });
    _controller.addListener(_onPositionChanged); // Add listener for position changes
    _controller.setLooping(false); // Ensure video does not loop automatically
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onPositionChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onPositionChanged() {
    // Trigger a rebuild when the position changes.
    if (_controller.value.position >= _controller.value.duration) {
      // Check if the video has reached the end, then replay it.
      _controller.seekTo(Duration.zero);
      _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      setState(() {});
    }
  }

  void _toggleFullScreen() {
    if (_isFullScreen) {
      // Exiting fullscreen mode
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      // Resume video playback
      // _controller.play();
      setState(() {});
    } else {
      // Entering fullscreen mode
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }

    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recordedContent.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: _controller.value.isInitialized
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        if (!_isFullScreen)
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                            bottom: 0,
                            top: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.skip_previous),
                                  onPressed: _skipBackward,
                                ),
                                Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                  child: IconButton(
                                    icon: Icon(
                                      _isPlaying ? Icons.pause : Icons.play_arrow,
                                      color: Colors.black87,
                                    ),
                                    onPressed: _togglePlayPause,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.skip_next),
                                  onPressed: _skipForward,
                                ),
                              ],
                            ),
                          ),
                        if (!_isFullScreen)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  VideoProgressIndicator(
                                    _controller,
                                    allowScrubbing: true,
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    colors: VideoProgressColors(backgroundColor: Colors.red.withOpacity(0.3), bufferedColor: Colors.grey, playedColor: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "${_formatDuration(_controller.value.position)}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.18,
                                        child: Row(
                                          children: <Widget>[
                                            // IconButton(
                                            //   icon: SvgPicture.asset("assets/images/volume.svg"),
                                            //   onPressed: _decreaseVolume,
                                            // ),
                                            Expanded(
                                              child: SliderTheme(
                                                data: SliderThemeData(
                                                  trackHeight: 2,
                                                  thumbShape: CustomSliderThumbCircle(thumbRadius: 6), // Adjust thumb size here
                                                ),
                                                child: Slider(
                                                  value: _volume,
                                                  onChanged: _setVolume,
                                                  activeColor: Colors.white,
                                                  thumbColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                              onPressed: _toggleFullScreen,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (_isFullScreen)
                          Positioned(
                            bottom: 0,
                            // left: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                                color: Colors.white,
                              ),
                              onPressed: _toggleFullScreen,
                            ),
                          )
                      ],
                    ),
                  ),
                )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Expanded(child: Column(children: [
            ListTile(
              title: Text("Open Group Discussion"),
              onTap: (){
                Get.to(ScreenGroupChat(event: widget.batch.id, expiry: widget.batch.status));
              },

            ),
            ListTile(
              title: Text("Open PPT File"),
              onTap: () async {
                String downloadLink = widget.recordedContent!.fileUrl;

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
                }              },

            ),
          ],))
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours > 0 ? "${duration.inHours}:" : ""}$twoDigitMinutes:$twoDigitSeconds";
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _skipForward() {
    int newDuration = _controller.value.position.inSeconds + 10;
    _controller.seekTo(Duration(seconds: newDuration));
  }

  void _skipBackward() {
    int newDuration = _controller.value.position.inSeconds - 10;
    _controller.seekTo(Duration(seconds: newDuration));
  }

  void _setVolume(double value) {
    setState(() {
      _volume = value.clamp(0.0, 1.0);
      _controller.setVolume(_volume);
    });
  }

  void _increaseVolume() {
    _setVolume(_volume + 0.1);
  }

  void _decreaseVolume() {
    _setVolume(_volume - 0.1);
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;

  CustomSliderThumbCircle({required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);
  }
}
