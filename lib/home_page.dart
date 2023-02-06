import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/login_widget.dart';
import 'package:firebase_sample/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Main page'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Signed in as'),
              Text(
                user.email!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('log out')),
            ],
          ),
        ));
  }
}
