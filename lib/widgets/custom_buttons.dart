import 'package:chat_app/constant.dart';
import 'package:chat_app/utils/responsive_font_size.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      minWidth: double.infinity,
      color: kSecondColor,
      height: 50,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: getResponsiveFontSize(
            context,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xffC8ECE7),
          fontSize: getResponsiveFontSize(
            context,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
