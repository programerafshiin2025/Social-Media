import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_x_flutter/Social_Page/componant/my_back_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current logged-in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserDetails() async {
    if (currentUser?.email == null) {
      return null; // Return null if no user is logged in
    }
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
            future: getUserDetails(),
            builder: (context, snapshot) {
              // If waiting for data
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // If there is an error
              else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              // If user is not logged in or document does not exist
              else if (!snapshot.hasData ||
                  snapshot.data == null ||
                  !snapshot.data!.exists) {
                return const Center(child: Text("No user data found."));
              }
              // Extract user data safely
              Map<String, dynamic>? user = snapshot.data!.data();
              if (user == null) {
                return const Center(child: Text("User data is empty."));
              }

              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 25),
                      child: Row(
                        children: [
                          MyBackButton(),
                          SizedBox(
                            width: 12,
                          ),
                          Text(" الحمد لله"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    //profile pic
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(23),
                      ),
                      padding: EdgeInsets.all(25),
                      child: const Icon(
                        Icons.person,
                        size: 64,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),

                    //user name
                    Text(
                      user["username"] ?? "Username not available",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //email
                    Text(
                      user["email"] ?? "Email not available",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }));
  }
}
