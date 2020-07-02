import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

List videoList = [
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4'
];

class VideoPlayer extends StatefulWidget {
  VideoPlayer({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VlcPlayerController _videoViewController;
  bool isPlaying = true;
  @override
  void initState() {
    _videoViewController = new VlcPlayerController(onInit: () {
      _videoViewController.play();
    });
    _videoViewController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new VlcPlayer(
      aspectRatio: 16 / 9,
      url: videoList[widget.index],
      controller: _videoViewController,
      placeholder: Container(
        height: 250.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator()],
        ),
      ),
    );
  }
}
