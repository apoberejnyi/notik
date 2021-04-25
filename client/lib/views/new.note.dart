import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';
import 'package:notik/views/edit.note.dart';

class NewNoteScreen extends StatelessWidget {
  final NotesService notesService;
  const NewNoteScreen({Key key, @required this.notesService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EditNoteScreen(
      notesService: notesService,
      note: Note.empty(),
      focus: EditNoteFocus.name,
    );
  }
}
