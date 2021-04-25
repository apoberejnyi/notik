import 'dart:math';

import 'package:notik/domain/note.dart';
import 'package:rxdart/rxdart.dart';

class NotesService {
  Map<String, Note> _notes = Map();

  BehaviorSubject<List<Note>> note$ = BehaviorSubject.seeded([]);

  void refresh() async {
    var seed = [
      Note("1", 'foo', 'here goes foobar'),
      Note("2", 'bar', 'here goes barfoo'),
    ];

    for (var note in seed) {
      _notes[note.id] = note;
    }

    this.note$.add(_notes.values.toList());
  }

  Future<void> set(Note note) async {
    if (note.id == null) {
      final rnd = Random();
      final id = rnd.nextInt(100).toString();
      note = note.copyWith(id: id);
    }

    _notes[note.id] = note;
    note$.add(_notes.values.toList());
  }

  void dispose() {
    note$.close();
  }
}
