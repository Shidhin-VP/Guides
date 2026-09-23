import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool isObscure;
  final bool readOnly;
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.readOnly = false,
    this.isObscure = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isObscure,
      validator: (value) {
        if (controller!.text.isEmpty) {
          return "Please Enter $hintText";
        }
        return null;
      },
    );
  }
}
