// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
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
            height: 55,
          ),
          const Text(
            'Chat',
            style: TextStyle(color: kSecondColor),
          ),
        ],
      ),
      actions: [
        IconButton(
          color: kSecondColor,
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            showSnackBar(context, message: 'Log Out Successfully');
          },
        ),
      ]);
}
