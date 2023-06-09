import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/onboarding/widgets/nav_tab.dart';
import 'package:tiktokclone/features/onboarding/widgets/post_video_button.dart';
import 'package:tiktokclone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    const Center(
        child: Text(
      "Home",
      style: TextStyle(fontSize: 49),
    )),
    const Center(
        child: Text(
      "Search",
      style: TextStyle(fontSize: 49),
    )),
    const Center(child: Text("Search")),
    const Center(child: Text("Inbox")),
    const Center(
        child: Text(
      "Profile",
      style: TextStyle(fontSize: 49),
    )),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Record Video"),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Offstage(
          offstage: _selectedIndex != 0,
          child: const VideoTimelineScreen(),
        ),
        Offstage(
          offstage: _selectedIndex != 1,
          child: Container(),
        ),
        Offstage(
          offstage: _selectedIndex != 3,
          child: Container(),
        ),
        Offstage(
          offstage: _selectedIndex != 4,
          child: Container(),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavTab(
                  icon: FontAwesomeIcons.house,
                  selectedIcon: FontAwesomeIcons.house,
                  isSelected: _selectedIndex == 0,
                  text: "Home",
                  onTap: () => _onTap(0),
                ),
                NavTab(
                  icon: FontAwesomeIcons.compass,
                  selectedIcon: FontAwesomeIcons.solidCompass,
                  isSelected: _selectedIndex == 1,
                  text: "Discover",
                  onTap: () => _onTap(1),
                ),
                Gaps.h24,
                GestureDetector(
                  onTap: _onPostVideoButtonTap,
                  child: const PostVideoButton(),
                ),
                Gaps.h24,
                NavTab(
                  icon: FontAwesomeIcons.message,
                  selectedIcon: FontAwesomeIcons.solidMessage,
                  isSelected: _selectedIndex == 3,
                  text: "Inbox",
                  onTap: () => _onTap(3),
                ),
                NavTab(
                  icon: FontAwesomeIcons.user,
                  selectedIcon: FontAwesomeIcons.solidUser,
                  isSelected: _selectedIndex == 4,
                  text: "Profile",
                  onTap: () => _onTap(4),
                ),
              ],
            ),
          )),
    );
  }
}
