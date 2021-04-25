import 'package:localstore/localstore.dart';
import 'package:notik/domain/note.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class NotesService {
  get note$ => _notesSubject.stream;
  var _notesSubject = BehaviorSubject<List<Note>>();

  final _db = Localstore.instance;
  final _dbCollection = 'notes';
  final _idGenerator = Uuid();

  void refresh() async {
    var items = await _db.collection(_dbCollection).get();

    if (items == null) {
      items = Map();
    }

    List<Note> notes = [];
    for (var e in items.entries) {
      Note n = Note.fromJSON(e.key, e.value);
      notes.add(n);
    }

    this._notesSubject.add(notes);
  }

  Future<void> set(Note note) async {
    if (note.id == null) {
      final id = _idGenerator.v4();
      note = note.copyWith(id: id);
    }

    DocumentRef doc = _db.collection(_dbCollection).doc(note.id);
    await doc.set(note.toJSON());

    var notes = _notesSubject.value ?? [];
    var index = notes.indexWhere((e) => e.id == note.id);
    if (index == -1) {
      notes.add(note);
    } else {
      notes[index] = note;
    }

    _notesSubject.add(notes);
  }

  void dispose() {
    _notesSubject.close();
  }

  Future<void> delete(Note note) async {
    if (note.id == null) {
      return;
    }

    DocumentRef doc = _db.collection(_dbCollection).doc(note.id);
    await doc.delete();

    var notes = _notesSubject.value ?? [];
    notes.removeWhere((e) => e.equals(note));

    _notesSubject.add(notes);
  }
}
