import 'package:firebase_sample/login_widget.dart';
import 'package:firebase_sample/signup_widget.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(onClickedSignup: toggle)
      : SignUpWidget(onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
