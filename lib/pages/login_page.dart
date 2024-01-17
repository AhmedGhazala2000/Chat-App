// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/buttons.dart';
import 'package:chat_app/widgets/text_form_field.dart';
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
  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

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
                  text: 'Email',
                  textInputType: TextInputType.emailAddress,
                  preIcon: Icons.email,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: passwordController,
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
                      isLoading = true;
                      setState(() {});
                      try {
                        await userLogIn();
                        showSnackBar(context, message: 'Successfully');
                        Navigator.pushNamed(context, ChatPage.id, arguments: userId);
                        emailController!.clear();
                        passwordController!.clear();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context,
                              message: 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              message:
                                  'Wrong password provided for that user.');
                        } else {
                          showSnackBar(context, message: e.code.toString());
                        }
                      } catch (e) {
                        showSnackBar(context,
                            message: 'there was an error, try later !');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {
                      showSnackBar(context,
                          message: 'please, enter the required fields');
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    CustomTextButton(
                      text: 'Register',
                      onPressed: () {
                        Navigator.pushNamed(context, Register.id);
                        emailController!.clear();
                        passwordController!.clear();
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
      email: emailController!.text,
      password: passwordController!.text,
    );
    userId = user.user!.uid;
  }
}
