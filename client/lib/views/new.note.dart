import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';
import 'package:notik/views/note.dart';

class NewNoteScreen extends StatefulWidget {
  final NotesService notesService;
  final void Function(Note) onSave;

  NewNoteScreen({
    Key? key,
    required this.notesService,
    required this.onSave,
  }) : super(key: key);

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  Note _note = Note.empty();

  @override
  Widget build(BuildContext context) {
    return NoteScreen(
      notesService: widget.notesService,
      note: _note,
      focus: EditNoteFocus.name,
      onSave: _saveNote,
    );
  }

  _saveNote(Note note) {
    setState(() {
      _note = Note.empty();
    });
    widget.onSave(note);
  }
}
