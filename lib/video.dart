import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

List videoList = ['https://mnmedias.api.telequebec.tv/m3u8/29880.m3u8'];

class VideoPlayer extends StatefulWidget {
  VideoPlayer({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VlcPlayerController _videoViewController;
  bool _isPlaying = true;
  Image _thumbnail;

  @override
  void initState() {
    super.initState();
    _videoViewController = new VlcPlayerController(onInit: () async {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () => _playOrPauseVideo(),
              onDoubleTap: () => _takeThumbnail(),
              child: VlcPlayer(
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
              ),
            ),
            _thumbnail != null
                ? _thumbnail
                : const Text('Double tap on the video'),
          ],
        );
      },
    );
  }

  void _playOrPauseVideo() {
    String state = _videoViewController.playingState.toString();

    if (_videoViewController.playbackSpeed != 0.0) {
      _videoViewController.setPlaybackSpeed(0.0);
      setState(() {
        _isPlaying = false;
      });
    } else {
      _videoViewController.setPlaybackSpeed(1.0);
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<void> _takeThumbnail() async {
    Uint8List data = await _videoViewController.takeSnapshot();
    setState(() => _thumbnail = Image.memory(data));
  }
}
