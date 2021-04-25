import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';
import 'package:notik/views/edit.note.dart';

class NoteDetailsScreen extends StatelessWidget {
  final NotesService notesService;
  final Note note;

  const NoteDetailsScreen({
    Key key,
    @required this.notesService,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EditNoteScreen(notesService: notesService, note: this.note);
  }
}
