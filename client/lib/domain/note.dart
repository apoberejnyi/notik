class Note {
  final String? id;
  final String name;
  final String text;

  Note(this.id, this.name, this.text);

  bool get isEmpty {
    return name == "" && text == "";
  }

  bool equals(Note note) {
    return id == note.id && name == note.name && text == note.text;
  }

  /// Checks whether a note matches search string
  bool matches(String str) {
    if (str.isEmpty) {
      return true;
    }
    final s = str.toLowerCase();
    return name.toLowerCase().contains(s) || text.toLowerCase().contains(s);
  }

  Note copyWith({String? id, String? name, String? text}) {
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
