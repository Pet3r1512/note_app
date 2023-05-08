import 'package:flutter/material.dart';
import 'package:notexpert_mongo/style/app_style.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Sign In"),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.pinkAccent),
              ),
              onPressed: () {},
              child: const Text(
                "Sign In",
                style: TextStyle(color: Colors.white),
              ))
        ]),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whitePink,
      appBar: AppBar(
        title: const Center(
          child: Text("Sign Up"),
        ),
        backgroundColor: AppStyle.pink,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.pinkAccent),
              ),
              onPressed: () {},
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ))
        ]),
      ),
    );
  }
}
