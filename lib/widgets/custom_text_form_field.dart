import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.text,
    this.textInputType,
    required this.preIcon,
    this.sufIcon,
    this.obscureText = false,
    this.onSaved,
    this.controller,
  });

  final String text;
  final TextInputType? textInputType;
  final IconData preIcon;
  final Widget? sufIcon;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (text) {
        if (text!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: onSaved,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: Icon(preIcon),
        suffixIcon: sufIcon,
        hintText: text,
        hintStyle: const TextStyle(color: kSecondColor),
        border: customBorder(color: kSecondColor),
        enabledBorder: customBorder(color: kSecondColor),
      ),
    );
  }

  InputBorder? customBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
