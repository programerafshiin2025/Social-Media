import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  //Get collection of Notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  //Cread : Add a new Note
  Future<void> AddNote(String note) async {
    try {
      await notes.add({
        'note': note,
        'timestamp': Timestamp.now(),
      });
      print("Note Added Successfully!"); // Debugging
    } catch (e) {
      print("Error adding note: $e");
    }
  }


  //Read : Get a Note from database
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }
  //Update : Update a Note given its ID
  Future<void> UpdateNote(String docID, String Newnote) {
    return notes.doc(docID).update({
      'note': Newnote,
      'timestamp': Timestamp.now(),
    });
  }
  //Delete: Delete a Note given its ID
  Future<void> DeleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
