class Note {
  final String? id;
  final String name;
  final String text;

  const Note(this.id, this.name, this.text);

  bool equals(Note note) {
    return id == note.id && name == note.name && text == note.text;
  }

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

  factory Note.fromJSON(Map<String, dynamic> json) {
    return Note(
      json['id'],
      json['name'],
      json['text'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': this.id,
      'name': this.name,
      'text': this.text,
    };
  }
}
