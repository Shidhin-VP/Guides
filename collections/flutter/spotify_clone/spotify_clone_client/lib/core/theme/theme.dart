import 'package:flutter/material.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';

class AppTheame {
  static OutlineInputBorder _border(Color borderSideColor) => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: borderSideColor, width: 3),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      enabledBorder: _border(Pallete.borderColor), // Look of initial button
      focusedBorder: _border(Pallete.gradient2), // Will focus when the button is clicked to type
    ),
  );
}
