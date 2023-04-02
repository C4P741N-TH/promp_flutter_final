import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:promp_flutter_final/main.dart';
import 'package:promp_flutter_final/service/note.dart';

class EditPage extends StatefulWidget {
  const EditPage(
      {super.key,
      required this.noteid,
      required this.noteName,
      required this.noteDesc});
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
  final _noteDTAdd = TextEditingController();

  String dtAdd = DateFormat.yMEd().format(DateTime.now()) +
      " " +
      DateFormat.jms().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    _noteName.text = widget.noteName;
    _noteDesc.text = widget.noteDesc;
    _noteDTAdd.text = dtAdd;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Reminder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
                controller: _noteDTAdd,
                decoration: const InputDecoration(
                    label: Text("Modified on"),
                    icon: Icon(Icons.calendar_month)),
                readOnly: true,
                enabled: false),
            TextField(
              controller: _noteName,
              decoration: const InputDecoration(label: Text("Reminder Title")),
            ),
            TextField(
              controller: _noteDesc,
              decoration:
                  const InputDecoration(label: Text("Reminder Description")),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _deleteNote,
                  icon: Icon(Icons.delete, color: Colors.red),
                  iconSize: 50,
                ),
                IconButton(
                    onPressed: _editNote,
                    icon: Icon(Icons.save, color: Colors.green),
                    iconSize: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editNote() {
    _noteService.editNote(widget.noteid,
        {"dtadd": dtAdd, "name": _noteName.text, "desc": _noteDesc.text});
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Reminder App')));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Updated")));
  }

  void _deleteNote() {
    _noteService.deleteNote(widget.noteid);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Reminder App')));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Deleted")));
  }
}
