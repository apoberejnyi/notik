import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/domain/note.dart';

/// NoteListItem expects that the parent list will set padding for the first element
class NoteListItem extends StatelessWidget {
  NoteListItem({required this.note, required this.onDelete});

  final void Function(Note) onDelete;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id!),
      onDismissed: (direction) => onDelete(note),
      background: Container(color: Colors.red),
      child: GestureDetector(
        onTap: () => _navToEditNote(context),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNoteTitle(context),
              ..._buildNoteText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteTitle(BuildContext context) {
    return Text(
      note.name,
      style: Theme.of(context).textTheme.headline5,
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
    );
  }

  List<Widget> _buildNoteText() {
    if (note.text.isEmpty) {
      return [];
    }

    return [
      Padding(padding: EdgeInsets.only(top: 16)),
      Text(
        note.text,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      )
    ];
  }

  _navToEditNote(BuildContext context) {
    Navigator.pushNamed(
      context,
      "/note",
      arguments: note,
    );
  }
}
