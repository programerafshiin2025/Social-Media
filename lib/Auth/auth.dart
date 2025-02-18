import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_x_flutter/Auth/login_and_register.dart';
import 'package:firebase_x_flutter/Social_Page/HomeAthPage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, Snapshot) {
            //User is login
            if (Snapshot.hasData) {
              return HomeAthPage();
            }
            //User is not login
            else {
              return const LoginAndRegister();
            }
          }),
    );
  }
}
