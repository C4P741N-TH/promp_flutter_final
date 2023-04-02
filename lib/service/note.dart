import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteService {
  Future<void> addNotetoDB(Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("note")
        .doc()
        .set(data)
        .then((value) {
      print("Note created");
    }).catchError((error) {
      print("Can't create note:" + error.toString());
    });
  }

  Future<void> editNote(String noteid, Map<String, String> data) {
    print(noteid);
    return FirebaseFirestore.instance
        .collection("note")
        .doc(noteid)
        .update(data)
        .then((value) {
      print("Note updated");
    }).catchError((error) {
      print("Can't update note:" + error.toString());
    });
  }

  Future<void> deleteNote(String noteid) {
    return FirebaseFirestore.instance
        .collection("note")
        .doc(noteid)
        .delete()
        .then((value) {
      print("Note deleted");
    }).catchError((error) {
      print("Can't delete note:" + error.toString());
    });
  }
}
