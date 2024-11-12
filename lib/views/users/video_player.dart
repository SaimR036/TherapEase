import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String name;

  VideoPlayerPage({required this.videoUrl, required this.name});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isFullscreen = false;
  bool _isMuted = false;
  bool _isPlaying = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        setState(() {
          _progress = _controller.value.position.inMilliseconds.toDouble();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
    if (_isFullscreen) {
      // Lock the orientation to landscape when fullscreen
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      // Reset orientation when exiting fullscreen
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _seekTo(double value) {
    setState(() {
      _progress = value;
      _controller.seekTo(Duration(milliseconds: value.toInt()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _isFullscreen
          ? Center(
              child: GestureDetector(
                onTap: _toggleFullscreen,
                child: Container(
                  color: Colors.black,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            )
          : Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF05696A), // First hex color (Blue)
                    Color(0xFF29BDBD), // Second hex color (Red)
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Video title
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.fromLTRB(0, height * 0.1, 0, 0),
                    child: Text(
                      '${widget.name}',
                      style: TextStyle(
                        fontFamily: 'Font',
                        color: Color(0xFF29BDBD),
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Video player and controls
                  _controller.value.isInitialized
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: height*0.2),
                              alignment: Alignment.center,
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: GestureDetector(
                                  onTap: _toggleFullscreen,
                                  child: VideoPlayer(_controller),
                                ),
                              ),
                            ),
                            // Play/Pause Button
                            Positioned(
                              bottom: 100,
                              child: IconButton(
                                icon: Icon(
                                  _isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_filled,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                onPressed: _togglePlayPause,
                              ),
                            ),
                            // Fullscreen Button
                            Positioned(
                              top: 20,
                              right: 20,
                              child: IconButton(
                                icon: Icon(
                                  _isFullscreen
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: _toggleFullscreen,
                              ),
                            ),
                            // Mute Button
                            Positioned(
                              top: 20,
                              left: 20,
                              child: IconButton(
                                icon: Icon(
                                  _isMuted ? Icons.volume_off : Icons.volume_up,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: _toggleMute,
                              ),
                            ),
                            // Progress Bar
                            Positioned(
                              bottom: 20,
                              child: Slider(
                                value: _progress,
                                min: 0.0,
                                max: _controller.value.duration.inMilliseconds.toDouble(),
                                onChanged: _seekTo,
                                activeColor: Colors.white,
                                inactiveColor: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      : Container(
                        margin: EdgeInsets.only(top: height*0.3),
                        child: CircularProgressIndicator(color: Colors.white)),
                ],
              ),
            ),
    );
  }
}
