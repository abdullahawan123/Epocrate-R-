// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerWidget extends StatefulWidget {
//   final VideoPlayerController controller;
//
//   const VideoPlayerWidget({
//     required this.controller,
//   });
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   bool _showIcons = true;
//   bool _isMuted = false;
//   double _volumeValue = 1.0;
//   Timer? _hideIconsTimer;
//   bool _isSliderActive = false;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(() {
//       if (!widget.controller.value.isPlaying && _showIcons) {
//         setState(() {
//           _showIcons = false;
//         });
//       }
//     });
//     widget.controller.setVolume(_isMuted ? 0.0 : _volumeValue);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(
//           () {
//             _showIcons = true;
//             _startHideIconsTimer();
//           },
//         );
//       },
//       onPanUpdate: (details) {
//         if (details.delta.dx.abs() > 0 || details.delta.dy.abs() > 0) {
//           _isSliderActive = true;
//         }
//         _showIcons = true;
//         _startHideIconsTimer();
//       },
//       child: Container(
//         child: buildVideo(),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _hideIconsTimer?.cancel();
//     super.dispose();
//   }
//
//   void _startHideIconsTimer() {
//     _hideIconsTimer?.cancel();
//
//     if (!_isSliderActive) {
//       _hideIconsTimer = Timer(Duration(seconds: 5), () {
//         setState(() {
//           _showIcons = false;
//         });
//       });
//     }
//
//     // Reset the slider activity status.
//     _isSliderActive = false;
//   }
//
//   Widget buildVideo() => GestureDetector(
//         onTap: () {
//           setState(() {
//             _showIcons = true;
//             _startHideIconsTimer();
//           });
//         },
//         child: Stack(
//           children: [
//             buildVideoPlayer(),
//             Positioned(
//               bottom: 7.h,
//               right: 2.w,
//               left: 2.w,
//               child: _showIcons
//                   ? VideoProgressIndicator(
//                       widget.controller,
//                       allowScrubbing: true,
//                     )
//                   : Container(),
//             ),
//             Positioned(
//               right: 0,
//               left: 0,
//               bottom: 0,
//               top: 0,
//               child: _showIcons
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             Icons.replay_10,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                           onPressed: seekBackward,
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             widget.controller.value.isPlaying
//                                 ? widget.controller.pause()
//                                 : widget.controller.play();
//                           },
//                           icon: Icon(
//                             widget.controller.value.isPlaying
//                                 ? Icons.pause_circle
//                                 : Icons.play_circle,
//                             color: Colors.white,
//                             size: 40,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.forward_10,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                           onPressed: seekForward,
//                         ),
//                       ],
//                     )
//                   : Container(),
//             ),
//             Positioned(
//               bottom: 2.h,
//               left: 3.w,
//               right: 0,
//               child: _showIcons
//                   ? Row(
//                       children: [
//                         VideoTimeIndicator(controller: widget.controller),
//                         Spacer(),
//                         IconButton(
//                           onPressed: () {
//                             _toggleMute();
//                           },
//                           icon: Icon(
//                             _isMuted ? Icons.volume_mute : Icons.volume_down,
//                             color: Colors.white,
//                             size: 22,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 30.w,
//                           child: Slider(
//                             value: _volumeValue,
//                             onChanged: _onVolumeChanged,
//                             activeColor: Colors.white,
//                             inactiveColor: Colors.white.withOpacity(0.5),
//                           ),
//                         ),
//                       ],
//                     )
//                   : Container(),
//             ),
//           ],
//         ),
//       );
//
//   Widget buildVideoPlayer() => AspectRatio(
//         aspectRatio: 16 / 9,
//         child: VideoPlayer(widget.controller),
//       );
//
//   void seekBackward() {
//     Duration currentPosition = widget.controller.value.position;
//     Duration seekToPosition = currentPosition - Duration(seconds: 10);
//     widget.controller.seekTo(seekToPosition);
//   }
//
//   void seekForward() {
//     Duration currentPosition = widget.controller.value.position;
//     Duration seekToPosition = currentPosition + Duration(seconds: 10);
//     widget.controller.seekTo(seekToPosition);
//   }
//
//   void _toggleMute() {
//     setState(() {
//       _isMuted = !_isMuted;
//       widget.controller.setVolume(_isMuted ? 0.0 : _volumeValue);
//     });
//   }
//
//   void _onVolumeChanged(double value) {
//     setState(() {
//       _volumeValue = value;
//       widget.controller.setVolume(_isMuted ? 0.0 : value);
//     });
//   }
// }
//
// class VideoTimeIndicator extends StatelessWidget {
//   final VideoPlayerController controller;
//
//   VideoTimeIndicator({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     Duration position = controller.value.position;
//     Duration duration = controller.value.duration;
//
//     String positionText = formatDuration(position);
//     String durationText = formatDuration(duration);
//
//     return Row(
//       children: [
//         Text(
//           positionText,
//           style: TextStyle(color: Colors.white),
//         ),
//         Text(
//           ' / ',
//           style: TextStyle(color: Colors.white),
//         ),
//         Text(
//           durationText,
//           style: TextStyle(color: Colors.white),
//         ),
//       ],
//     );
//   }
//
//   String formatDuration(Duration duration) {
//     int minutes = duration.inMinutes;
//     int seconds = duration.inSeconds.remainder(60);
//     return '$minutes:${seconds.toString().padLeft(2, '0')}';
//   }
// }
