
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truckpag_challenge/api/data/Word.dart';
import '../../api/Api.dart';
import '../../database/data/MeaningData.dart';

final detailWordViewModel = ChangeNotifierProvider((ref) => DetailWordViewModel());

class DetailWordViewModel extends ChangeNotifier{

  bool isLoadingContent = false;
  String pronunciation = "";
  final List<String> meaning = [];

  _loadContent(){
    isLoadingContent = !isLoadingContent;
  }

  fillData(String pronunciation, List<MeaningData> meaning){
    cleanVariables();
    this.pronunciation = pronunciation;
    for(var element in meaning){
      this.meaning.add(element.meaning);
    }
  }

  cleanVariables(){
    isLoadingContent = false;
    pronunciation = "";
    meaning.clear();
  }

  Future<dynamic> getWordDescription(word) async {
    cleanVariables();
    _loadContent();

    final response = await Api.instance.getWord(word);

    if(response is Word) {
      pronunciation = response.pronunciation.all;

      for (var element in response.results) {
        meaning.add(element.definition);
      }

      _loadContent();
      notifyListeners();

      return response;

    } else {
      pronunciation = '';
      meaning.clear();
      _loadContent();
      notifyListeners();
      return false;

    }





  }

}