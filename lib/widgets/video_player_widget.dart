// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:startupfunding/widgets/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  VideoPlayerController controller;
  VideoPlayerWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller != null && controller.value.isInitialized
        ? Container(
            alignment: Alignment.topCenter,
            child: buildVideo(),
          )
        : Container(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget buildVideo() => Stack(
    children: [
      buildVideoPlayer(),
      Positioned.fill(child: BasicOverlayWidget(controller: controller)),
    ],
  );

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}
