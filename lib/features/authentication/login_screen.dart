import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';

import 'widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void onSignUpTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          children: const [
            Gaps.v80,
            Text(
              'Log in for TikTok',
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v20,
            Text(
              'Manage your account, check notifications, comment on videos, and more.',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black45,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.v40,
            AuthButton(
              text: 'Use email and password',
              icon: FaIcon(
                FontAwesomeIcons.user,
              ),
            ),
            Gaps.v16,
            AuthButton(
              text: 'Continue with Apple',
              icon: FaIcon(
                FontAwesomeIcons.apple,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade100,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                ),
                Gaps.h8,
                GestureDetector(
                  onTap: () => onSignUpTap(context),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
