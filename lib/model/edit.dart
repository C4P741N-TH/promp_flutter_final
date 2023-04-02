import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promp_flutter_final/service/note.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    super.key,
    required this.noteid,
    required this.noteName,
    required this.noteDesc,
  });
  final String noteid;
  final String noteName;
  final String noteDesc;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final NoteService _noteService = NoteService();
  final _noteName = TextEditingController();
  final _noteDesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _noteName.text = widget.noteName;
    _noteDesc.text = widget.noteDesc;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _noteName,
              decoration: const InputDecoration(label: Text("Note name")),
              readOnly: false,
            ),
            TextField(
              controller: _noteDesc,
              decoration:
                  const InputDecoration(label: Text("Note Description")),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: _deleteNote, child: const Text("Delete")),
            ),
            ElevatedButton(onPressed: _editNote, child: const Text("Edit"))
          ],
        ),
      ),
    );
  }

  void _editNote() {
    _noteService.editNote(
        widget.noteid, {"name": _noteName.text, "desc": _noteDesc.text});
  }

  void _deleteNote() {
    _noteService.deleteNote(_noteName.text);
  }
}
