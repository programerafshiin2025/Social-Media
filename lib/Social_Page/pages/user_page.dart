import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_x_flutter/Social_Page/componant/My_list_title.dart';
import 'package:firebase_x_flutter/Social_Page/componant/my_back_button.dart';
import 'package:firebase_x_flutter/helper/helper_user.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").snapshots(),
            builder: (context, snapshot) {
              //any error
              if (snapshot.hasError) {
                displayMessageToUser("Something went wrong", context);
              }
              //Show leading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data == null) {
                return const Text("No data ");
              }
              //  //get all users
              final users = snapshot.data!.docs;
              return Column(
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
                  Expanded(
                    child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, Index) {
                          //get indivual
                          final user = users[Index];
                          //get data from each user
                          String username = user["username"];
                          String email = user["email"];
                          return MyListTitle(title: username, subTitle: email);
                        }),
                  ),
                ],
              );
            }));
  }
}
