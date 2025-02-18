import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_x_flutter/Database/firestore.dart';
import 'package:firebase_x_flutter/Social_Page/componant/My_list_title.dart';
import 'package:firebase_x_flutter/Social_Page/componant/my_drawer.dart';
import 'package:firebase_x_flutter/Social_Page/componant/my_post_button.dart';
import 'package:firebase_x_flutter/Social_Page/componant/mytextfield.dart';
import 'package:flutter/material.dart';

class HomeAthPage extends StatefulWidget {
  HomeAthPage({super.key});

  @override
  State<HomeAthPage> createState() => _HomeAthPageState();
}

class _HomeAthPageState extends State<HomeAthPage> {
  // Firestore access
  FirestoreDatabase database = FirestoreDatabase();

  // Text controller
  TextEditingController NewpostContoller = TextEditingController();

  // Post Message
  void postMessage() {
    if (NewpostContoller.text.isNotEmpty) {
      String message = NewpostContoller.text;
      database.addPost(message);
      // Clear after posting
      NewpostContoller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(" الحمد لله"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
        ),
        drawer: MyDrawer(),
        body: Column(
          children: [
            // TextField Box for user input
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Mytextfield(
                        hinttext: "Say Something",
                        obscuretext: false,
                        controller: NewpostContoller),
                  ),
                  // Post button
                  MyPostButton(
                    onTap: postMessage,
                  )
                ],
              ),
            ),
            // Posts
            StreamBuilder(
                stream: database.getPostStream(),
                builder: (context, snapshot) {
                  // Show loading circle
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text("No Posts Available."),
                      ),
                    );
                  }
                  final posts = snapshot.data!.docs;

                  return Expanded(
                      child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // Get each individual post
                      final post = posts[index].data() as Map<String, dynamic>;

                      // Get data safely
                      String message = post["postMessage"] ?? "No message";
                      String userEmail = post["userEmail"] ?? "Unknown User";
                      Timestamp? timestamp = post["timestamp"];
                      print(timestamp);

                      // Return as list tile
                      return MyListTitle(
                        title: message,
                        subTitle: userEmail,
                      );
                    },
                  ));
                })
          ],
        ));
  }
}
