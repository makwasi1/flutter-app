import 'package:citizen_feedback/theme/theme.dart';
import 'package:flutter/material.dart';

class TextFieldDecoration {
  final Icon prefixIcon;
  final Icon suffixIcon;
  final String hintText;

  const TextFieldDecoration({Key key, this.prefixIcon, this.suffixIcon, this.hintText});

  InputDecoration draw() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white12)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Turquoise)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Turquoise)),
    );
  }
}
