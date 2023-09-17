class Word {
  String word;
  List<Results> results;
  Syllables syllables;
  Pronunciation pronunciation;

  Word(
      {required this.word,
      required this.results,
      required this.syllables,
      required this.pronunciation});

  factory Word.fromJson(Map<String, dynamic> json) {
    var results = json.containsKey('results') ? json['results'] as List<dynamic> : [];
    var syllables = json.containsKey('syllables') ? json['syllables'] as dynamic : [];
    var pronunciation = json.containsKey('pronunciation') ? json['pronunciation'] as dynamic : [];

    List<Results> resultsList =
        results.map((data) => Results.fromJson(data as Map<String, dynamic>)).toList();

    Syllables resultSyllables = Syllables.fromJson(syllables);

    Pronunciation resultPronunciation = Pronunciation.fromJson(pronunciation);

    return Word(
        word: json['word'] as String,
        results: resultsList,
        syllables: resultSyllables,
        pronunciation: resultPronunciation);
  }
}

class Results {
  String definition;
  String? partOfSpeech;
  List<String>? synonyms;
  List<String>? typeOf;
  List<String>? hasTypes;
  List<String>? derivation;
  List<String>? examples;

  Results(
      {required this.definition,
      required this.partOfSpeech,
      required this.synonyms,
      required this.typeOf,
      required this.hasTypes,
      required this.derivation,
      required this.examples});

  factory Results.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      print(json['hasTypes']);
      return Results(
          definition: json.containsKey('definition') ? json['definition'] as String : "",
          partOfSpeech: json.containsKey('partOfSpeech') ? json['partOfSpeech'] as String : "",
          synonyms: json.containsKey('synonyms') ? (json['synonyms'] as List).map((item) => item as String).toList() : [],
          typeOf: json.containsKey('typeOf') ? (json['typeOf'] as List).map((item) => item as String).toList() : [],
          hasTypes: json.containsKey('hasTypes') ? (json['hasTypes'] as List).map((item) => item as String).toList() : [],
          derivation: json.containsKey('derivation') ? (json['derivation'] as List).map((item) => item as String).toList() : [],
          examples: json.containsKey('examples') ? (json['examples'] as List).map((item) => item as String).toList() : []);
    } else {
      return Results(
          definition: 'Unknown Error',
          partOfSpeech: null,
          synonyms: null,
          typeOf: null,
          hasTypes: null,
          derivation: null,
          examples: null);
    }
  }
}

class Syllables {
  int count;
  List<String> list;

  Syllables({required this.count, required this.list});

  factory Syllables.fromJson(dynamic json) {
    if (json.isNotEmpty) {
      return Syllables(
          count: json['count'] as int, list: (json['list'] as List).map((item) => item as String).toList());
    } else {
      return Syllables(count: 0, list: []);
    }
  }
}

class Pronunciation {
  String all;

  Pronunciation({required this.all});

  factory Pronunciation.fromJson(dynamic json) {
    if (json.isNotEmpty) {
      return Pronunciation(all: json['all'] as String);
    } else {
      return Pronunciation(all: '');
    }
  }
}
