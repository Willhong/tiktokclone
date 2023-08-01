import 'package:flutter/material.dart';
import 'package:tiktokclone/features/videos/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  @override
  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;
  final PageController _pageController = PageController();
  int _itemCount = 3;

  void _onPageChanged(int index) {
    _pageController.animateToPage(
      index,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (index == _itemCount - 1) {
      _itemCount += 4;
    }
    setState(() {});
  }

  void _onVideoFinished() {
    return;
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  Future<void> _onRefresh() async {
    return Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 50,
      edgeOffset: 10,
      color: Theme.of(context).primaryColor,
      onRefresh: _onRefresh,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _itemCount,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          return VideoPost(onVideoFinished: _onVideoFinished, index: index);
        },
      ),
    );
  }
}
