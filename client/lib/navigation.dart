import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/views/new.note.dart';
import 'package:notik/views/notes.list.dart';

class NotikNavigation extends StatefulWidget {
  final NotesService notesService;
  const NotikNavigation({Key? key, required this.notesService})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotikNavigationState();
  }
}

class _NotikNavigationState extends State<NotikNavigation> {
  int _selectedIndex = 1;

  Widget _getSelectedView() {
    if (_selectedIndex == 0) {
      return NewNoteScreen(
        notesService: widget.notesService,
        onSave: (note) => _setSelectedIndex(1),
      );
    }

    return NotesListScreen(
      notesService: widget.notesService,
    );
  }

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedView(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "New Note",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Folders',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _setSelectedIndex,
      ),
    );
  }
}
