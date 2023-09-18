class Env{

  static const Map<String, String> _keys = {
    'X-RapidAPI-Key': String.fromEnvironment('X_RapidApi_Key') ,
    'X-RapidAPI-Host': String.fromEnvironment('X_RapidAPI_Host'),
    'Content-Type': 'application/json'
  };

  static String _getKey(String key){
    final value = _keys[key] ?? '';
    if(value.isEmpty){
      throw Exception('$key is not set in Env');
    }

    return value;
  }

  static String get xRapidKey => _getKey('X-RapidAPI-Key');
  static String get xRapidHost => _getKey('X-RapidAPI-Host');


}