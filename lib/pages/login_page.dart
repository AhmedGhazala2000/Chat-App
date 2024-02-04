// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_buttons.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  static String id = 'Log In';

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? email, password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode? autoValidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  String? userId;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidateMode,
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Scholar Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  controller: emailController,
                  onSaved: (value) {
                    email = value;
                  },
                  text: 'Email',
                  textInputType: TextInputType.emailAddress,
                  preIcon: Icons.email,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: passwordController,
                  onSaved: (value) {
                    password = value;
                  },
                  text: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  preIcon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomMaterialButton(
                  text: 'Log In',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      isLoading = true;
                      setState(() {});
                      try {
                        await userLogIn();
                        showSnackBar(context, message: 'Log In Successfully');
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: userId);
                        emailController.clear();
                        passwordController.clear();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context,
                              message: 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              message:
                                  'Wrong password provided for that user.');
                        } else {
                          log(e.toString());
                          showSnackBar(context, message: e.code.toString());
                        }
                      } catch (e) {
                        log(e.toString());
                        showSnackBar(context,
                            message: 'There was an error, Please try later !');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {
                      showSnackBar(context,
                          message: 'Please enter the required fields');
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    CustomTextButton(
                      text: 'Register',
                      onPressed: () {
                        Navigator.pushNamed(context, Register.id);
                        emailController.clear();
                        passwordController.clear();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userLogIn() async {
    final UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    userId = user.user!.uid;
  }
}
