import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*

this database stories posts that the user has published
in the App
it is sored is collections called posts in firebase
each post contains
a massege
emails of user
and Timetam
 */

class FirestoreDatabase {
  //current loged in user
  User? user = FirebaseAuth.instance.currentUser;
  //get collection  of post from firestore
  CollectionReference posts = FirebaseFirestore.instance.collection("Posts");
  //post message
  Future<void> addPost(String message) {
    return posts.add({
      "userEmail": user!.email,
      "postMessage": message,
      "timestamp": Timestamp.now(),
    });
  }

  //read posts from database
  Stream<QuerySnapshot> getPostStream() {
    final postStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("timestamp", descending: true)
        .snapshots();
    return postStream;
  }
}
