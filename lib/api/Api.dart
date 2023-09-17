import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:truckpag_challenge/api/data/Message.dart';
import 'package:truckpag_challenge/api/data/Word.dart';

class Api {
  final link = 'wordsapiv1.p.rapidapi.com';
  final xRapidApiKey = '8876f7bdcbmsh2a37df037fc0155p11617ejsn36fed5d6c915';
  final xRapidApiHost = 'wordsapiv1.p.rapidapi.com';
  static final Api _instance = Api._internal();
  Api._internal();
  static Api get instance => _instance;

  Future<dynamic> getWord(String word) async {
    final url = Uri.https(link, '/words/$word');

    final headers = {
      'X-RapidAPI-Key': xRapidApiKey,
      'X-RapidAPI-Host': xRapidApiHost,
      'Content-Type': 'application/json'
    };

    final response = await http.get(url, headers: headers);

    final parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final responseParsed = Word.fromJson(parsed);
      return responseParsed;
    } else {
      final responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }
}
