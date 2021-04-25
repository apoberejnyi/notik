class Note {
  final String name;
  final String text;

  const Note(this.name, this.text);

  factory Note.empty() {
    return Note('', '');
  }
}
