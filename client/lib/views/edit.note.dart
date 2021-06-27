import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';

enum EditNoteFocus { name, none }

class EditNoteScreen extends StatefulWidget {
  final NotesService notesService;
  final Note note;
  final EditNoteFocus? focus;
  final void Function(Note) onSave;

  EditNoteScreen({
    Key? key,
    required this.notesService,
    required this.note,
    required this.onSave,
    this.focus,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _nameController = TextEditingController();
  final _textController = TextEditingController();
  final _textFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.note.name;
    _textController.text = widget.note.text;

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? BackButton(color: Theme.of(context).accentColor)
            : null,
        title: Text("Edit note"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save note',
            onPressed: _saveNote,
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => _textFocus.requestFocus(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildNoteNameField(context),
            _buildNoteTextField(),
          ],
        ),
      ),
    );
  }

  TextField _buildNoteNameField(BuildContext context) {
    return TextField(
      autofocus: widget.focus == EditNoteFocus.name,
      controller: _nameController,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.headline4!.fontSize,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Note name',
      ),
      textInputAction: TextInputAction.next,
    );
  }

  TextField _buildNoteTextField() {
    return TextField(
      controller: _textController,
      focusNode: _textFocus,
      maxLines: null,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Note text',
      ),
    );
  }

  _saveNote() async {
    final note = widget.note.copyWith(
      name: _nameController.text,
      text: _textController.text,
    );

    if (note.isEmpty) {
      await widget.notesService.delete(note);
      final snackBar = SnackBar(content: Text('Empty note is deleted'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await widget.notesService.set(note);
    }

    this.widget.onSave(note);
  }
}
