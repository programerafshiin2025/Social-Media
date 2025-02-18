import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_x_flutter/Social_Page/componant/mybutton.dart';
import 'package:firebase_x_flutter/Social_Page/componant/mytextfield.dart';
import 'package:firebase_x_flutter/helper/helper_user.dart';
import 'package:flutter/material.dart';

class RegistorPage extends StatefulWidget {
  final void Function()? onTop;

  RegistorPage({super.key, required this.onTop});

  @override
  State<RegistorPage> createState() => _RegistorPageState();
}

class _RegistorPageState extends State<RegistorPage> {
  
  final TextEditingController UserNameController = TextEditingController();

  final TextEditingController EmailController = TextEditingController();

  final TextEditingController PasswordController = TextEditingController();

  final TextEditingController ConfPasswordController = TextEditingController();

  //Registor function
  void RegisterUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    //check if password and confirm password are the same
    if (PasswordController.text != ConfPasswordController.text) {
      //pop loading circle
      Navigator.pop(context);
      //show error message to user
      displayMessageToUser("Passwords do not match", context);
    }
    //if pass do match
    else {
      //try creating a new user
      try {
        //create user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: EmailController.text,
          password: PasswordController.text,
        );
        //print(userCredential.user?.uid);

        //create  a user documents and add to firebase
        createUserDocument(userCredential);
        //pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop loading circle
        Navigator.pop(context);
        //show error message to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  //create a user document and collect them in  firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    //create a user documents
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        "email": userCredential.user!.email,
        "username": UserNameController.text,
      });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Registor
              Icon(Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary),
              //app name
              SizedBox(
                height: 25,
              ),
              Text(
                "S O C I A L",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 25,
              ),
              //UserName textfield
              Mytextfield(
                  hinttext: "Username",
                  obscuretext: false,
                  controller: UserNameController),
              SizedBox(
                height: 40,
              ),
              //Email textfield
              Mytextfield(
                  hinttext: "Email",
                  obscuretext: false,
                  controller: EmailController),
              SizedBox(
                height: 40,
              ),

              //password textfield
              Mytextfield(
                  hinttext: "password",
                  obscuretext: false,
                  controller: PasswordController),
              SizedBox(
                height: 40,
              ),
              //Confirm Pass textfield
              Mytextfield(
                  hinttext: "ConfPass",
                  obscuretext: false,
                  controller: ConfPasswordController),
              SizedBox(
                height: 40,
              ),
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
              //Registor in button
              SizedBox(
                height: 20,
              ),
              Mybutton(
                text: "Register",
                OnTop: RegisterUser,
              ),
              SizedBox(height: 25),
              //I  Already have  an account Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I  Already have  an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: widget.onTop,
                    child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
