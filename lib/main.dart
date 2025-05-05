import 'package:firebase_x_flutter/Auth/auth.dart';

import 'package:firebase_x_flutter/Social_Page/HomeAthPage.dart';
import 'package:firebase_x_flutter/Social_Page/pages/profile_page.dart';
import 'package:firebase_x_flutter/Social_Page/pages/user_page.dart';

import 'package:firebase_x_flutter/Theme/Themeligt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home:AuthPage(),
      theme: dirkMode,
      darkTheme: dirkMode,

      routes: {
        '/auth': (context) => const AuthPage(),
        '/home': (context) => HomeAthPage(),
        '/profile': (context) => ProfilePage(),
        '/user': (context) => const UserPage(),
      },
    );
  }
}
