import 'package:localstorage/localstorage.dart';
import 'package:notik/domain/note.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class NotesService {
  ValueStream<List<Note>> get note$ => _notesSubject.stream;
  var _notesSubject = BehaviorSubject<List<Note>>();

  final _db = LocalStorage('notik');
  final _dbCollection = "notes";
  final _idGenerator = Uuid();

  void init() async {
    await _db.ready;
    List<dynamic>? json = await _db.getItem(_dbCollection);

    List<Note> notes = (json ?? []).map((e) => Note.fromJSON(e)).toList();
    this._notesSubject.add(notes);
  }

  Future<void> set(Note note) async {
    if (note.id == null) {
      final id = _idGenerator.v4();
      note = note.copyWith(id: id);
    }

    var notes = _notesSubject.value ?? [];
    var index = notes.indexWhere((e) => e.id == note.id);
    if (index == -1) {
      notes.add(note);
    } else {
      notes[index] = note;
    }

    await _updateNotes(notes);
  }

  Future<void> delete(Note note) async {
    if (note.id == null) {
      return;
    }

    var notes = _notesSubject.value ?? [];
    var index = notes.indexWhere((e) => e.id == note.id);

    if (index != -1) {
      notes.removeAt(index);
    }

    await _updateNotes(notes);
  }

  Future<void> _updateNotes(List<Note> notes) async {
    List<dynamic> json = notes.map((n) => n.toJSON()).toList();
    await _db.ready;
    await _db.setItem(_dbCollection, json);

    _notesSubject.add(notes);
  }

  void dispose() {
    _notesSubject.close();
  }
}
