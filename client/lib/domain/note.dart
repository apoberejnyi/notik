class Note {
  final String? id;
  final String name;
  final String text;

  const Note(this.id, this.name, this.text);

  copyWith({String? id, String? name, String? text}) {
    return Note(
      id ?? this.id,
      name ?? this.name,
      text ?? this.text,
    );
  }

  factory Note.empty() {
    return Note(null, '', '');
  }
}
