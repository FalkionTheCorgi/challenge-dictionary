import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:truckpag_challenge/database/data/WordDescription.dart';
import 'DB.dart';

final wordDescriptionRepository = ChangeNotifierProvider((ref) => WordDescriptionRepository());

class WordDescriptionRepository extends ChangeNotifier{

  late Database db;
  final List<WordDescriptionData> _wordDescription = [];

  List<WordDescriptionData> get wordDescription => _wordDescription;

  WordDescription(){
    _initRepository();
  }

  _initRepository() async {
    await _getWordDescription();
  }

  _getWordDescription() async {
    db = await DB.instance.database;
    List wordDescription = await db.query('word_description');
    for (var element in wordDescription) {
      _wordDescription.add(WordDescriptionData(id: element['id'], word: element['word'], pronunciation: element['pronunciation'], idMeaning: element['id_meaning']));
    }
    notifyListeners();
  }

  bool existWord(word) {

    return wordDescription.where((element) => element.word == word).isNotEmpty;

  }


  addWordDescription(word, pronunciation, idMeaning) async {

    db = await DB.instance.database;

    final exist = wordDescription.where((element) => element.word == word).isNotEmpty;

    if(!exist) {
      await db.insert(
          'word_description',
          { 'word': word,
            'pronunciation': pronunciation,
            'id_meaning': idMeaning
          },
          conflictAlgorithm: ConflictAlgorithm.replace
      );

      _wordDescription.clear();

      _getWordDescription();

      notifyListeners();
    }



  }

  removeWordDescription(word) async {

    db = await DB.instance.database;

    await db.delete(
        'word_description',
        where: 'word = ?',
        whereArgs: [word]
    );

    _wordDescription.clear();

    _getWordDescription();

    notifyListeners();

  }



}