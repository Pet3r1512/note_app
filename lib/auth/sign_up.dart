import 'package:flutter/material.dart';
import 'package:notexpert_mongo/style/app_style.dart';
import 'package:notexpert_mongo/widgets/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whitePink,
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: AppStyle.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          reusableTextField("Email", Icons.person, false, emailController),
          const SizedBox(
            height: 20,
          ),
          reusableTextField("Password", Icons.password, true, passController),
          const SizedBox(
            height: 20,
          ),
          reusableTextField(
              "Confirm Password", Icons.check, true, confirmController),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Colors.pinkAccent,
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () {
                if (passController.text.compareTo(confirmController.text) ==
                    0) {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text)
                      .then((value) {
                    print("Success");
                    Navigator.of(context).pop();
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
