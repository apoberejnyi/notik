import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';

class NotesListScreen extends StatefulWidget {
  final NotesService notesService;
  const NotesListScreen({Key? key, required this.notesService})
      : super(key: key);

  @override
  createState() {
    return _NotesListScreenState();
  }
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  void initState() {
    super.initState();
    this.widget.notesService.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes List"),
      ),
      body: Center(
        child: StreamBuilder<List<Note>>(
            stream: this.widget.notesService.note$, builder: _buildList),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navToNewNote,
        tooltip: "New Note",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
    var d = snapshot.data;
    if (d != null) {
      List<_NoteWidget> children = [];
      for (var e in d) {
        children.add(_NoteWidget(e));
      }

      return ListView(children: children);
    }

    if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    return CircularProgressIndicator();
  }

  void _navToNewNote() {
    Navigator.pushNamed(
      context,
      "/newnote",
    );
  }
}

class _NoteWidget extends StatelessWidget {
  const _NoteWidget(this._note);
  final Note _note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/note",
          arguments: _note,
        );
      },
      child: Card(
        shadowColor: Theme.of(context).shadowColor,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _note.name,
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              Text(_note.text, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
