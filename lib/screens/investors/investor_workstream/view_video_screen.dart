import 'package:flutter/material.dart';
import 'package:startupfunding/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class ViewVideoScreen extends StatefulWidget {
  final String videoUrl;
  ViewVideoScreen({required this.videoUrl});

  @override
  State<ViewVideoScreen> createState() => _ViewVideoScreenState();
}

class _ViewVideoScreenState extends State<ViewVideoScreen> {
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Video",
          style: TextStyle(
              fontFamily: "Cabin",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: widget.videoUrl == ""
          ? Center(child: Image(image: AssetImage("assets/not_found.jpeg")))
          : SingleChildScrollView(
              child: Column(
                children: [
                  VideoPlayerWidget(controller: controller),
                  SizedBox(
                    height: 32,
                  ),
                  if (controller != null && controller.value.isInitialized)
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: IconButton(
                            onPressed: () {
                              controller.setVolume(isMuted ? 1 : 0);
                            },
                            icon: Icon(
                              isMuted ? Icons.volume_mute : Icons.volume_up,
                              color: Colors.white,
                            )))
                ],
              ),
            ),
    );
  }
}
