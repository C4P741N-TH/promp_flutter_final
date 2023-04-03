import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:promp_flutter_final/service/auth.dart';

class NoteService {
  AuthService _service = AuthService();

  Future<void> addNotetoDB(Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection(_service.user!.email.toString())
        .doc()
        .set(data)
        .then((value) {
      print("Reminder created");
    }).catchError((error) {
      print("Can't create reminder:" + error.toString());
    });
  }

  Future<void> editNote(String noteid, Map<String, String> data) {
    print(noteid);
    return FirebaseFirestore.instance
        .collection(_service.user!.email.toString())
        .doc(noteid)
        .update(data)
        .then((value) {
      print("Reminder updated");
    }).catchError((error) {
      print("Can't update reminder:" + error.toString());
    });
  }

  Future<void> deleteNote(String noteid) {
    return FirebaseFirestore.instance
        .collection(_service.user!.email.toString())
        .doc(noteid)
        .delete()
        .then((value) {
      print("Reminder deleted");
    }).catchError((error) {
      print("Can't delete reminder:" + error.toString());
    });
  }
}
