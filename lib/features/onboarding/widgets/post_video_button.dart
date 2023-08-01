import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({super.key, required this.inverted});

  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 5,
          child: Container(
            height: 30,
            width: 35,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: const BoxDecoration(
                color: Color(0xff61D4F0),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Center(
                child: Text(
              "3",
              style: TextStyle(color: Colors.black),
            )),
          ),
        ),
        Positioned(
          left: 5,
          child: Container(
            height: 30,
            width: 35,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Center(
                child: Text(
              "3",
              style: TextStyle(color: Colors.black),
            )),
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size8, vertical: Sizes.size4),
            decoration: BoxDecoration(
              color: inverted ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 30,
            width: 35,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: inverted ? Colors.black : Colors.white,
                size: 18,
              ),
            ))
      ],
    );
  }
}
