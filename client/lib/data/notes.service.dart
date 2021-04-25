import 'package:notik/domain/note.dart';
import 'package:rxdart/rxdart.dart';

class NotesService {
  BehaviorSubject<List<Note>> note$ = BehaviorSubject.seeded([]);

  void refresh() async {
    // await Future.delayed(Duration(seconds: 2));
    var notes = [
      Note('foo', 'here goes foobar'),
      Note('bar', 'here goes barfoo'),
    ];
    this.note$.add(notes);
  }

  Future<void> add(Note note) async {
    var newNotes = this.note$.value;
    newNotes.add(note);
    note$.add(newNotes);
  }

  void dispose() {
    note$.close();
  }
}
