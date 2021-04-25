import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/domain/note.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note _note;
  NoteDetailsScreen(this._note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes List"),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: this._note.name),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline4.fontSize,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note name',
                ),
              )),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: this._note.text),
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
}
