import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_x_flutter/services/firebase.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseService firebaseService = FirebaseService();
  final TextEditingController textController = TextEditingController();
  //Open a dialog box to add a new note
  void Openbox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Enter your note here',
          ),
        ),
        actions: [
          //button to add note
          ElevatedButton(
              onPressed: () {
                //Add new note
                if (docID == null) {
                  firebaseService.AddNote(textController.text);
                }
                //update note
                else {
                  firebaseService.UpdateNote(docID, textController.text);
                }

                //Close the dialog box
                Navigator.pop(context);
                //Clear the text field
                textController.clear();
              },
              child: Text("Add"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Active Members ',
          style: TextStyle(color: Colors.deepOrange),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firebaseService.getNotesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //if we have data get all doc
              List ListNote = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: ListNote.length,
                  itemBuilder: (context, index) {
                    //get each individual doc
                    DocumentSnapshot document = ListNote[index];
                    String docID = document.id;
                    //get the note from the doc
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String noteText = data['note'];
                    //display as list tile
                    return Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                          title: Text(noteText),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //Update button
                              IconButton(
                                onPressed: () => Openbox(docID: docID),
                                icon: Icon(Icons.settings),
                              ),
                              //Delete
                              IconButton(
                                onPressed: () {
                                  firebaseService.DeleteNote(docID);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          )),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: Openbox,
        child: const Icon(Icons.add),
      ),
    );
  }
}
