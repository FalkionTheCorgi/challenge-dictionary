class WordDescriptionData {
  int id;
  String word;
  String pronunciation;
  String idMeaning;

  WordDescriptionData(
      {required this.id,
      required this.word,
      required this.pronunciation,
      required this.idMeaning});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'pronunciation': pronunciation,
      'meaning': idMeaning
    };
  }

  @override
  String toString() {
    return 'WordDescriptionData{id: $id, word: $word, pronunciation: $pronunciation, meaning: $idMeaning}';
  }
}
