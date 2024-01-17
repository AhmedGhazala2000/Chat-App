import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.text,
    required this.textInputType,
    required this.preIcon,
    this.obscureText = false,
    this.controller
  });

  final String text;
  final TextInputType textInputType;
  final IconData preIcon;
  final bool obscureText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text){
        if(text!.isEmpty){
          return 'this field is required';
        }
        return null;
      },
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: Icon(preIcon),
        hintText: text,
        hintStyle: const TextStyle(color: kSecondColor),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kSecondColor,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kSecondColor,
          ),
        ),
      ),
    );
  }
}
