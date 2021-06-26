import 'package:flutter/material.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';
import 'package:notik/theme/colors.dart';
import 'package:notik/views/new.note.dart';
import 'package:notik/views/note.details.dart';
import 'package:notik/views/notes.list.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final NotesService _notesService = NotesService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: accent,
        appBarTheme: AppBarTheme(backgroundColor: navigation),
        scaffoldBackgroundColor: backround,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: navigationText),
        ),
      ),
      initialRoute: '',
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    if (settings.name == '/note') {
      return MaterialPageRoute(
        builder: (context) => NoteDetailsScreen(
          notesService: _notesService,
          note: settings.arguments as Note,
        ),
      );
    }

    if (settings.name == '/newnote') {
      return MaterialPageRoute(
        builder: (context) => NewNoteScreen(
          notesService: this._notesService,
        ),
      );
    }

    return MaterialPageRoute(
      builder: (context) => NotesList(
        notesService: this._notesService,
      ),
    );
  }
}
