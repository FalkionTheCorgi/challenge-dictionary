class MeaningData {
  int id;
  String meaning;
  String fkWordDescription;

  MeaningData(
      {required this.id,
        required this.meaning,
        required this.fkWordDescription});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meaning': meaning,
      'fk_word_description': fkWordDescription,
    };
  }

  @override
  String toString() {
    return 'MeaningData{id: $id, meaning: $meaning, fk_word_description: $fkWordDescription}';
  }
}
