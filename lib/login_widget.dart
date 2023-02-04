import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/main.dart';
import 'package:firebase_sample/reset_%20password.dart';
import 'package:firebase_sample/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignup;

  const LoginWidget({required this.onClickedSignup, super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: 'email', border: OutlineInputBorder()),
            ),
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
            ),
            const SizedBox(
              height: 13,
            ),
            ElevatedButton.icon(
                onPressed: signIn,
                icon: Icon(Icons.lock_outline),
                label: Text('Log In')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPassword(),
                      ));
                },
                child: Text('Forgot Password?')),
            RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  text: 'No Account? ',
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignup,
                        text: 'Sign Up',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 18))
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
