import 'package:flutter/material.dart';
import 'package:notexpert_mongo/style/app_style.dart';
import 'package:notexpert_mongo/screen/home.dart';
import 'package:notexpert_mongo/widgets/reusable_widgets.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whitePink,
      appBar: AppBar(
        title: const Center(
          child: Text("Sign In"),
        ),
        backgroundColor: AppStyle.pink,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.05, 20, 0),
          child: Column(
            children: <Widget>[
              reusableTextField("Email", Icons.person, false, emailController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField(
                  "Password", Icons.password, true, passController),
              const SizedBox(
                height: 30,
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              signUpOption(),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SignUp(),
              ));
            },
            child: Text(
              "Sign Up",
              style:
                  TextStyle(color: AppStyle.pink, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
