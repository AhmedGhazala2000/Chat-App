// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/widgets/custom_buttons.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static String id = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode? autoValidateMode = AutovalidateMode.disabled;
  bool isLoading = false;

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
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
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
                  text: 'Register',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      isLoading = true;
                      setState(() {});
                      try {
                        await userRegister();
                        showSnackBar(context,
                            message: 'Success, Please Log In.');
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context,
                              message: 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              message:
                                  'The account already exists for that email.');
                        } else {
                          log(e.toString());
                          showSnackBar(context, message: e.message.toString());
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
                      'Already have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    CustomTextButton(
                      text: 'Log In',
                      onPressed: () {
                        Navigator.pop(context);
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

  Future<void> userRegister() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
