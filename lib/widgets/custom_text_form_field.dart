import 'package:chat_app/constant.dart';
import 'package:chat_app/utils/responsive_font_size.dart';
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
  });

  final String text;
  final TextInputType? textInputType;
  final IconData preIcon;
  final Widget? sufIcon;
  final bool obscureText;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        hintStyle: TextStyle(
          color: kSecondColor,
          fontSize: getResponsiveFontSize(
            context,
            fontSize: 14,
          ),
        ),
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
