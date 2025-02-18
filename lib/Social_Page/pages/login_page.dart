import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_x_flutter/Social_Page/componant/mybutton.dart';
import 'package:firebase_x_flutter/Social_Page/componant/mytextfield.dart';
import 'package:firebase_x_flutter/helper/helper_user.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTop;
  LoginPage({super.key, required this.onTop});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController EmailController = TextEditingController();

  final TextEditingController PasswordController = TextEditingController();

  //login function
  void Login() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    //try to sign in
    try {
      //sign in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: EmailController.text,
        password: PasswordController.text,
      );
      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    }
    //display
    on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //show error message to user
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //login
                Icon(Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary),
                //app name
                SizedBox(
                  height: 25,
                ),
                Text(
                  "S O C I A L M E D I A",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 25,
                ),
                //email textfield
                Mytextfield(
                    hinttext: "Email",
                    obscuretext: false,
                    controller: EmailController),
                SizedBox(
                  height: 30,
                ),
                //password textfield
                Mytextfield(
                    hinttext: "password",
                    obscuretext: true,
                    controller: PasswordController),
                //forgot password
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
                //sign in button
                SizedBox(
                  height: 20,
                ),
                Mybutton(
                  text: "Login",
                  OnTop: Login,
                ),
                SizedBox(height: 20),
                //dont have an account register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: widget.onTop,
                      child: Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
