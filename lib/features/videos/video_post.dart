import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/features/videos/widgets/video_button.dart';
import 'package:tiktokclone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  final Function onVideoFinished;
  final int index;
  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  bool _isPaused = false;
  bool _isExpanded = false;
  final Duration _animationDuration = const Duration(milliseconds: 250);
  late final AnimationController _animationController;
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/video/a.mp4");
  String message = 'This is a game I made in 2 days!';
  void onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.play();
    _videoPlayerController.addListener(() {
      onVideoChanged();
    });
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    message.length > 20 ? _isExpanded = false : _isExpanded = true;
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _videoPlayerController.pause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onSeeMoreTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const VideoComments(),
      backgroundColor: Colors.transparent,
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.index.toString()),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.teal,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
              child: IgnorePointer(
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  );
                },
                child: AnimatedOpacity(
                  duration: _animationDuration,
                  opacity: _isPaused ? 1 : 0,
                  child: const FaIcon(
                    FontAwesomeIcons.play,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          )),
          Positioned(
            bottom: 20,
            left: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: _isExpanded
                  ? MediaQuery.of(context).size.height * 0.2
                  : MediaQuery.of(context).size.height * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "@willhong",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v10,
                  Row(
                    children: [
                      _isExpanded
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                message,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : Text(
                              message.substring(0, 20),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                      Gaps.h6,
                      GestureDetector(
                        onTap: _onSeeMoreTap,
                        child: Text(
                          _isExpanded ? "See less" : "See more",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  child: Text("경택"),
                ),
                Gaps.v24,
                const VideoButton(
                    icon: FontAwesomeIcons.solidHeart, text: "2.9M"),
                Gaps.v24,
                GestureDetector(
                    onTap: () {
                      _onCommentTap(context);
                    },
                    child: const VideoButton(
                        icon: FontAwesomeIcons.solidComment, text: "33K")),
                Gaps.v24,
                const VideoButton(icon: FontAwesomeIcons.share, text: "Share"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
