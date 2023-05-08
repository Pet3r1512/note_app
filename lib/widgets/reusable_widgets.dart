import 'package:flutter/material.dart';
import 'package:notexpert_mongo/style/app_style.dart';

TextFormField reusableTextField(
    String text, IconData icon, bool isPass, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPass,
    enableSuggestions: !isPass,
    autocorrect: !isPass,
    cursorColor: Colors.red,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: AppStyle.pink),
      labelText: text,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppStyle.pink.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType:
        isPass ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}
