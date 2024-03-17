// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/utils/responsive_font_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: kPrimaryColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/scholar.png',
          height: 50,
        ),
        Text(
          'Chat',
          style: TextStyle(
            color: kSecondColor,
            fontSize: getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        color: kSecondColor,
        icon: const Icon(Icons.logout),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, LogInPage.id);
          showSnackBar(context, message: 'Log Out Successfully');
        },
      ),
    ],
  );
}
