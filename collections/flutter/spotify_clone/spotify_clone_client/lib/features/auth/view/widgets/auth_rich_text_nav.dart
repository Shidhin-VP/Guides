import 'package:flutter/material.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';

class AuthRichTextNav extends StatelessWidget {
  final String welcomeText;
  final String action;
  const AuthRichTextNav({
    super.key,
    required this.welcomeText,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: welcomeText,
        style: Theme.of(context).textTheme.titleMedium,
        children: [
          TextSpan(
            text: action,
            style: TextStyle(color: AppPallete.gradient3),
          ),
        ],
      ),
    );
  }
}
