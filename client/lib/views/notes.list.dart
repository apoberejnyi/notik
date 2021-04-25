import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';
import 'package:notik/views/mixins/list.search.dart';

class NotesList extends StatefulWidget {
  final NotesService notesService;
  const NotesList({
    Key? key,
    required this.notesService,
  }) : super(key: key);

  @override
  createState() {
    return _NotesListState();
  }
}

class _NotesListState extends State<NotesList> with ListSearch<NotesList> {
  @override
  void initState() {
    super.initState();
    this.widget.notesService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearching ? const BackButton() : null,
        title: isSearching
            ? buildSearchField(searchHint: "Search notes...")
            : Text("Notes List"),
        actions: buildSearchActions(),
      ),
      body: Center(
        child: StreamBuilder<List<Note>>(
          stream: widget.notesService.note$,
          builder: _buildList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navToNewNote,
        tooltip: "New Note",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
    var listData = snapshot.data;

    if (listData != null) {
      var children = listData
          .where((n) => n.matches(searchQuery))
          .map((e) => _NoteWidget(e, widget.notesService));
      return ListView(children: children.toList());
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
  const _NoteWidget(this._note, this._service);

  final NotesService _service;
  final Note _note;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(_note.id!),
      onDismissed: _deleteNote,
      child: GestureDetector(
        onTap: () => _navToEditNote(context),
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
      ),
    );
  }

  _deleteNote(DismissDirection dir) {
    _service.delete(_note);
  }

  _navToEditNote(BuildContext context) {
    Navigator.pushNamed(
      context,
      "/note",
      arguments: _note,
    );
  }
}
