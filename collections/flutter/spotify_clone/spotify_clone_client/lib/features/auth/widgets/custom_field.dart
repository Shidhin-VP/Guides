import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  const CustomField({super.key, required this.hintText, required this.controller, this.isObscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText
      ),
      validator: (value) {
        if(value!.isEmpty){
          return "$hintText is missing";
        }
        return null;
      },
    );// Will validate the entire page and all of it's field.
  }
}