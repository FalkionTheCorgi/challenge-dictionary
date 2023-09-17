import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import 'DB.dart';
import 'data/CardDB.dart';

final favoriteRepository = ChangeNotifierProvider((ref) => FavoriteRepository());

class FavoriteRepository extends ChangeNotifier {

  late Database db;
  final List<CardDB> _favorite = [];

  List<CardDB> get favorite => _favorite;

  FavoriteRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getFavorite();
  }

  _getFavorite() async {
    db = await DB.instance.database;
    List history = await db.query('favorite');
    for (var element in history) {
      _favorite.add(CardDB(id: element['id'], word: element['word']));
    }
    notifyListeners();
  }

  addFavorite(word) async {

    db = await DB.instance.database;

    await db.insert(
        'favorite',
        { 'word' : word },
        conflictAlgorithm: ConflictAlgorithm.replace
    );

    _favorite.clear();

    _getFavorite();

    notifyListeners();

  }

  removeFavorite(word) async {

    db = await DB.instance.database;

    await db.delete(
      'favorite',
      where: 'word = ?',
      whereArgs: [word]
    );

    _favorite.clear();

    _getFavorite();

    notifyListeners();

  }

}