import 'package:flutter/material.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';

class NoteDeletion {
  final NotesService notesService;
  final BuildContext context;

  NoteDeletion(this.notesService, this.context);

  delete(Note note) async {
    await notesService.delete(note);

    final undoBar = SnackBar(
      content: Text('Note is deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => notesService.set(note),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(undoBar);
  }
}
