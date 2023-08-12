import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:keepnotes_clone/services/login_info.dart';
import '../model/MyNoteModel.dart';
import 'db.dart';

class FireDB {
  //CREATE,READ,UPDATE,DELETE
  final FirebaseAuth _auth = FirebaseAuth.instance;

  createNewNoteFirestore(Note note, String id) async {
    LocalDataSaver.getSyncSet().then((isSyncOn) async {
      print(isSyncOn);
      if (isSyncOn.toString() == "true") {
        final User? current_user = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(current_user!.email)
            .collection("usernotes")
            .doc(id)
            .set({
          "Title": note.title,
          "content": note.content,
          "date": note.createdTime,
        }).then((_) {
          print("DATA ADDED SUCESSFULLY");
        });
      }
    });
  }

  getAllStoredNotes() async {
    final User? current_user = _auth.currentUser;
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(current_user!.email)
        .collection("usernotes")
        .orderBy("date")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Map note = result.data();

        NotesDatabase.instance.InsertEntry(Note(
            title: note["Title"],
            content: note["content"],
            createdTime: note["date"],
            pin: false,
            isArchieve: false)); //Add Notes In Database
      });
    });
  }

  updateNoteFirestore(Note note) async {
    LocalDataSaver.getSyncSet().then((isSyncOn) async {
      if (isSyncOn.toString() == "true") {
        final User? current_user = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(current_user!.email.toString())
            .collection("usernotes")
            .doc(note.id.toString())
            .update({
          "Title": note.title.toString(),
          "content": note.content
        }).then((_) {
          print("DATA UPDATED SUCESSFULLY");
        });
      }
    });
  }

  deleteNoteFirestore(Note note) async {
    LocalDataSaver.getSyncSet().then((isSyncOn) async {
      if (isSyncOn.toString() == "true") {
        final User? current_user = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(current_user!.email.toString())
            .collection("usernotes")
            .doc(note.id.toString())
            .delete()
            .then((_) {
          print("DATA DELETED SUCESSFULLY");
        });
      }
    });
  }
}
