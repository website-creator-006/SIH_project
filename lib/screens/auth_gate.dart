import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_phone.dart';
import 'splash_screen.dart';
import 'navigation.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const SplashScreen(); // fancy loader
        }
        if (snap.hasData) {
          return const MainNavigation(); // user logged in
        }
        return const LoginPhoneScreen(); // ask for phone login
      },
    );
  }
}
