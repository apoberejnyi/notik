import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';

class NotesOverview extends StatefulWidget {
  final NotesService notesService;
  const NotesOverview({Key key, @required this.notesService}) : super(key: key);

  @override
  createState() {
    return _NotesOverviewState();
  }
}

class _NotesOverviewState extends State<NotesOverview> {
  Future<List<Note>> _notes;

  @override
  void initState() {
    super.initState();
    this._notes = this.widget.notesService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
        future: this._notes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var children = snapshot.data.map((e) => _NoteWidget(e)).toList();
            return ListView(children: children);
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return CircularProgressIndicator();
        });
  }
}

class _NoteWidget extends StatelessWidget {
  const _NoteWidget(this._note);
  final Note _note;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[400],
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _note.name,
            style: Theme.of(context).textTheme.headline4,
            overflow: TextOverflow.ellipsis,
          ),
          Text(_note.text, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
