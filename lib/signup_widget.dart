import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({super.key, required this.onClickedSignIn});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: 'email', border: OutlineInputBorder()),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    labelText: 'password', border: OutlineInputBorder()),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter min. 6 character'
                    : null,
              ),
              const SizedBox(
                height: 13,
              ),
              ElevatedButton.icon(
                  onPressed: signIn,
                  icon: Icon(Icons.arrow_forward),
                  label: Text('Sign Up')),
              RichText(
                text: TextSpan(
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    text: 'Already have an Account? ',
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          text: 'Log In',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ))
                    ]),
                    
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    //Navigator.of(context) not working!
    navigationKey.currentState!.popUntil((route) => route.isFirst);
  }
}
