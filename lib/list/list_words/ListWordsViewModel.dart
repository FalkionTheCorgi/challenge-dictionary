import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

final listWordsViewModel = ChangeNotifierProvider((ref) => ListWordsViewModel());

class ListWordsViewModel extends ChangeNotifier {

  List<String> words = [];
  List<String> wordShowed = [];
  int page = 1;

  resetPage(){
    words = [];
    wordShowed = [];
    page = 1;
    notifyListeners();
  }

  Future<void> getWords() async {

    resetPage();

    final file = rootBundle.loadString('assets/words_dictionary.json');

    try {
      Map<String, dynamic> jsonMap = json.decode(await file);
      words = jsonMap.keys.toList();
      getWordsByPage();
      notifyListeners();
    } catch (e) {
      print('Erro ao ler/analisar o arquivo JSON: $e');
    }
  }

  getWordsByPage() async {

    await Future.delayed(const Duration(seconds: 3));

    for (int i = wordShowed.length; i < 30*page; i++) {
      wordShowed.add(words[i]);
    }

    page++;

    notifyListeners();

  }

}
