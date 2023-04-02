import 'package:flutter/material.dart';
import 'package:promp_flutter_final/main.dart';
import 'package:promp_flutter_final/service/note.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _noteName = TextEditingController();
  final _noteDesc = TextEditingController();

  final NoteService _noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _noteName,
              decoration: InputDecoration(label: Text("Reminder Title")),
            ),
            TextField(
              controller: _noteDesc,
              decoration: InputDecoration(label: Text("Reminder Description")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                _createNote();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Successful")));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              title: 'Reminder App',
                            )));
              },
              child: const Text("Add Note"),
            ),
          ],
        ),
      ),
    );
  }

  _createNote() {
    _noteService.addNotetoDB({"name": _noteName.text, "desc": _noteDesc.text});
  }
}
