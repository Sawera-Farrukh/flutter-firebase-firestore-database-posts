import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepractice/ui/auth/login_screen.dart';
import 'package:firebasepractice/ui/choice_screen.dart';   // ← add this
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      // Already logged in → go to Choice Screen
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChoiceScreen()),
        );
      });
    } else {
      // Not logged in → go to Login
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    }
  }
}