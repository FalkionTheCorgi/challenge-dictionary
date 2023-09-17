import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:truckpag_challenge/database/data/WordDescription.dart';

import 'DB.dart';
import 'data/MeaningData.dart';

final meaningRepository = ChangeNotifierProvider((ref) => MeaningRepository());

class MeaningRepository extends ChangeNotifier{

  late Database db;
  final List<MeaningData> _meaning = [];

  List<MeaningData> get meaning => _meaning;

  MeaningRepository(){
    _initRepository();
  }

  _initRepository() async {
    await _getMeaning();
  }

  _getMeaning() async {
    db = await DB.instance.database;
    List meaning = await db.query('meaning');
    _meaning.clear();
    for (var element in meaning) {
      _meaning.add(MeaningData(id: element['id'], meaning: element['meaning'], fkWordDescription: element['fk_word_description']));
    }
    notifyListeners();
  }

  addMeaning(meaning, fkWordDescription) async {

    db = await DB.instance.database;

    final exist = this.meaning.where((element) => element.fkWordDescription == fkWordDescription).isNotEmpty;

    if(!exist) {
      await db.insert(
          'meaning',
          { 'meaning': meaning,
            'fk_word_description': fkWordDescription
          },
          conflictAlgorithm: ConflictAlgorithm.replace
      );

      _meaning.clear();

      _getMeaning();

      notifyListeners();
    }



  }

  removeMeaning(fkWordDescription) async {

    db = await DB.instance.database;

    await db.delete(
        'meaning',
        where: 'fk_word_description = ?',
        whereArgs: [fkWordDescription]
    );

    _meaning.clear();

    _getMeaning();

    notifyListeners();

  }



}