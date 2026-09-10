import 'package:flutter/material.dart';
import 'package:spotify_clone_client/core/theme/app_theme.dart';
import 'package:spotify_clone_client/features/auth/view/pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.darkThemeMode, home: SignUp());
  }
}
