
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Login"),
          TextFormField(
            controller: email,
            decoration: const InputDecoration(hintText: 'email'),
          ),
          TextFormField(
            controller: password,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'password'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: _login, child: const Text("Login")),
          )
        ],
      ),
    ));
  }

  void _login() {
    if (email.text.isEmpty || password.text.isEmpty) {
      if (kDebugMode) {
        print("fill all details");
      }
    } else {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    }
  }
}
