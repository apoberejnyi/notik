import 'package:flutter/material.dart';
import 'package:notik/data/notes.service.dart';
import 'package:notik/domain/note.dart';
import 'package:notik/navigation.dart';
import 'package:notik/theme/colors.dart';
import 'package:notik/views/edit.note.dart';

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
        iconTheme: IconThemeData(color: accent),
        appBarTheme: AppBarTheme(
          backgroundColor: navigation,
          actionsIconTheme: IconThemeData(color: accent),
        ),
        scaffoldBackgroundColor: backround,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: accent,
        ),
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
        builder: (context) => EditNoteScreen(
          notesService: _notesService,
          note: settings.arguments as Note,
        ),
      );
    }

    return MaterialPageRoute(
      builder: (context) => NotikNavigation(
        notesService: this._notesService,
      ),
    );
  }
}
