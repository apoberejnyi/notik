import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';
import 'package:notik/views/mixins/list.search.dart';
import 'package:notik/widgets/note.list.item.dart';

class NotesList extends StatefulWidget {
  final NotesService notesService;

  NotesList({
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
        leading: isSearching
            ? BackButton(color: Theme.of(context).accentColor)
            : null,
        title: isSearching
            ? buildSearchField(searchHint: "Search notes...")
            : Text("Notes List"),
        actions: buildSearchActions(context),
      ),
      body: Center(
        child: StreamBuilder<List<Note>>(
          stream: widget.notesService.note$,
          builder: _buildList,
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
    var listData = snapshot.data;

    if (listData != null) {
      if (listData.isEmpty) {
        return _buildEmptyList();
      }

      var children = listData.where((n) => n.matches(searchQuery)).map(
            (e) => NoteListItem(
              note: e,
              onDelete: _deleteNote,
            ),
          );
      return ListView(
        padding: EdgeInsets.only(top: 16),
        children: children.toList(),
      );
    }

    if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    return CircularProgressIndicator();
  }

  Widget _buildEmptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('assets/images/cat.png')),
        Container(
          padding: EdgeInsets.only(top: 24),
          child: Text('Press "+" to add a note'),
        )
      ],
    );
  }

  void _deleteNote(Note note) async {
    await widget.notesService.delete(note);

    final undoBar = SnackBar(
      content: Text('Note is deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => widget.notesService.set(note),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(undoBar);
  }
}
