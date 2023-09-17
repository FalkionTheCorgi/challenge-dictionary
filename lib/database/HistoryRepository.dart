import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'DB.dart';
import 'data/CardDB.dart';

final historyRepository = ChangeNotifierProvider((ref) => HistoryRepository());

class HistoryRepository extends ChangeNotifier{

  late Database db;
  final List<CardDB> _history = [];

  List<CardDB> get history => _history;

  HistoryRepository(){
    _initRepository();
  }

  _initRepository() async {
    await _getHistory();
  }

  _getHistory() async {
    db = await DB.instance.database;
    List history = await db.query('history');
    for (var element in history) {
      _history.add(CardDB(id: element['id'], word: element['word']));
    }
    notifyListeners();
  }

  addHistory(word) async {

    db = await DB.instance.database;

    final exist = history.where((element) => element.word == word).isNotEmpty;

    if(!exist) {
      await db.insert(
          'history',
          { 'word': word},
          conflictAlgorithm: ConflictAlgorithm.replace
      );

      _history.clear();

      _getHistory();

      notifyListeners();
    }



  }

  removeFavorite(word) async {

    db = await DB.instance.database;

    await db.delete(
        'history',
        where: 'word = ?',
        whereArgs: [word]
    );

    _history.clear();

    _getHistory();

    notifyListeners();

  }



}