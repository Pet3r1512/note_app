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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();
  late bool isObscure;
  String? errorMsg = '';
  bool isLoading = false;

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
        key: _key,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            reusableTextField(
                "Email", Icons.person, false, emailController, validateEmail),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: validatePassword,
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
                  setState(() {
                    isLoading = true;
                  });

                  if (_key.currentState!.validate()) {
                    if (passController.text.compareTo(confirmController.text) ==
                        0) {
                      try {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text);
                        errorMsg = '';

                        Navigator.of(context).pop();
                      } on FirebaseAuthException catch (err) {
                        errorMsg = err.message;
                      }
                    } else {
                      errorMsg = "Password does not match";
                    }
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(
                        color: AppStyle.whitePink,
                      )
                    : const Text(
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

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return "Email address is required";
    }

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return "Invalid Email Address";

    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return "Password is required";
    }
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword)) {
      return '''
      Password must at least 6 characters,
      Include an uppercase and number
      ''';
    }
    return null;
  }
}
