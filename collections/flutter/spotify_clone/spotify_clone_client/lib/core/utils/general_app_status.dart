import 'package:flutter/material.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';

ScaffoldMessengerState showAppStatus(
  BuildContext context, {
  required String message,
  bool error = false,
}) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: !error ? AppPallete.greenColor : AppPallete.errorColor,
      ),
    );
}
