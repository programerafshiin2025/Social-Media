import 'package:firebase_x_flutter/Social_Page/pages/login_page.dart';
import 'package:firebase_x_flutter/Social_Page/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginAndRegister extends StatefulWidget {
  const LoginAndRegister({super.key});

  @override
  State<LoginAndRegister> createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
  //inialisation
  bool ShowLoginPage = true;
  //toggle between login and register
  void togglePages() {
    setState(() {
      ShowLoginPage = !ShowLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ShowLoginPage) {
      return LoginPage(onTop: togglePages);
    } else {
      return RegistorPage(onTop: togglePages);
    }
  }
}
