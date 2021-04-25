import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';

enum EditNoteFocus { name, none }

class EditNoteScreen extends StatefulWidget {
  final NotesService notesService;
  final Note note;
  final EditNoteFocus? focus;

  EditNoteScreen({
    Key? key,
    required this.notesService,
    required this.note,
    this.focus,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditNoteScreenState();
  }
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late Note note;

  @override
  void initState() {
    super.initState();
    this.note = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit note"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save note',
            onPressed: _setNote,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              autofocus: widget.focus == EditNoteFocus.name,
              controller: TextEditingController(text: note.name),
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline4!.fontSize,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note name',
              ),
              onChanged: (val) => note = note.copyWith(name: val),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: TextEditingController(text: note.text),
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note text',
                ),
                onChanged: (val) => note = note.copyWith(text: val),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setNote() async {
    await widget.notesService.set(note);
    Navigator.pop(context);
  }
}
