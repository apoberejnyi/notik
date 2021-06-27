import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';
import 'package:notik/usecases/delete.note.dart';
import 'package:notik/views/note.dart';

class EditNoteScreen extends StatelessWidget {
  final NotesService notesService;
  final Note note;

  const EditNoteScreen({
    Key? key,
    required this.notesService,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoteScreen(
      notesService: notesService,
      note: this.note,
      onSave: (note) => Navigator.pop(context),
      extraActions: [
        IconButton(
          icon: Icon(Icons.delete_outline),
          tooltip: 'Delete Note',
          onPressed: () async {
            await NoteDeletion(notesService, context).delete(note);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
