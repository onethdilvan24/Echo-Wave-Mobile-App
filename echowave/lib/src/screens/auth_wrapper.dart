import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:echowave/src/screens/Home.dart';


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),  // Listen to auth state changes
      builder: (context, snapshot) {
        // If the snapshot has user data, that means the user is signed in
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading screen while waiting for the auth state to resolve
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasData) {
          // If user is signed in, show the HomeScreen
          return const HomeScreen();
        }

        // If the user is not signed in, show the LoginScreen
        return const LoginScreen();
      },
    );
  }
}
