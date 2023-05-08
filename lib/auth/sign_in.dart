import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String? errorMsg = '';
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
        title: const Center(
          child: Text("Sign In"),
        ),
        backgroundColor: AppStyle.pink,
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.05, 20, 0),
              child: Column(
                children: <Widget>[
                  reusableTextField("Email", Icons.person, false,
                      emailController, validateEmail),
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
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                    ),
                    keyboardType: isObscure
                        ? TextInputType.visiblePassword
                        : TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    errorMsg!,
                    style: TextStyle(color: AppStyle.pink),
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
                        if (_key.currentState!.validate()) {
                          try {
                            FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passController.text);
                            errorMsg = '';
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                          } on FirebaseAuthException catch (err) {
                            errorMsg = err.message;
                          }
                          setState(() {});
                        }
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
