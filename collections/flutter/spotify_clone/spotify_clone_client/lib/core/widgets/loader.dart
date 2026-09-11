import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive());
  }
}