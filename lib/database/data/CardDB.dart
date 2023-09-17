class CardDB{

  int id;
  String word;

  CardDB({required this.id, required this.word});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': word,
    };
  }

  @override
  String toString() {
    return 'CardDB{id: $id, word: $word}';
  }

}