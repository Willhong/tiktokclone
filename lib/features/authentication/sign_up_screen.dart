import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/gaps.dart';
import 'package:tiktokclone/constants/sizes.dart';
import 'package:tiktokclone/features/authentication/username_screen.dart';
import 'package:tiktokclone/features/authentication/login_screen.dart';
import 'package:tiktokclone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          children: [
            Gaps.v80,
            const Text(
              'Sign Up for TikTok',
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v20,
            const Text(
              'Create a profile, follow other accounts, make your own videos, and more.',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black45,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.v40,
            AuthButton(
              text: 'Use phone or email',
              icon: const FaIcon(
                FontAwesomeIcons.user,
              ),
              onTap: _onEmailTap,
            ),
            Gaps.v16,
            AuthButton(
              text: 'Continue with Apple',
              icon: const FaIcon(
                FontAwesomeIcons.apple,
              ),
              onTap: (context) {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade50,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                ),
                Gaps.h8,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    'Log in',
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
