import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';

class NewNoteScreen extends StatefulWidget {
  final NotesService notesService;
  const NewNoteScreen({Key key, @required this.notesService}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewNoteScreenState();
  }
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  Note _newNote = Note.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New note"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Create note',
            onPressed: _addNote,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                autofocus: true,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline4.fontSize,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note name',
                ),
                onChanged: (val) => _newNote = Note(val, _newNote.text),
              )),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note text',
                ),
                onChanged: (val) => _newNote = Note(_newNote.name, val),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _addNote() async {
    await widget.notesService.add(_newNote);
    _newNote = Note.empty();
    Navigator.pop(context);
  }
}
