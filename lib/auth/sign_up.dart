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
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whitePink,
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: AppStyle.pink,
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            reusableTextField("Email", Icons.person, false, emailController),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passController,
              obscureText: isObscure,
              cursorColor: Colors.red,
              style: TextStyle(color: Colors.black.withOpacity(0.9)),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password, color: AppStyle.pink),
                suffixIcon: IconButton(
                  icon: isObscure
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                labelText: "Password",
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: AppStyle.pink.withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
              keyboardType: isObscure
                  ? TextInputType.visiblePassword
                  : TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: confirmController,
              obscureText: isObscure,
              cursorColor: Colors.red,
              style: TextStyle(color: Colors.black.withOpacity(0.9)),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password, color: AppStyle.pink),
                suffixIcon: IconButton(
                  icon: isObscure
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                labelText: "Confirm Password",
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: AppStyle.pink.withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
              keyboardType: isObscure
                  ? TextInputType.visiblePassword
                  : TextInputType.text,
            ),
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
      ),
    );
  }
}
