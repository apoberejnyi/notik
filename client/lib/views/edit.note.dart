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
  final nameController = TextEditingController();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.note.name;
    textController.text = widget.note.text;
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
            onPressed: _saveNote,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              autofocus: widget.focus == EditNoteFocus.name,
              controller: nameController,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline4!.fontSize,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note name',
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: textController,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note text',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _saveNote() async {
    final note = widget.note.copyWith(
      name: nameController.text,
      text: textController.text,
    );

    if (note.isEmpty) {
      await widget.notesService.delete(note);
      final snackBar = SnackBar(content: Text('Empty note is deleted'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await widget.notesService.set(note);
    }

    Navigator.pop(context);
  }
}
