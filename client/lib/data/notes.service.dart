import 'dart:io';

import 'package:notik/domain/note.dart';

class NotesService {
  Future<List<Note>> getAll() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Note('foo', 'here goes foobar'),
      Note('bar', 'here goes barfoo'),
    ];
  }
}
