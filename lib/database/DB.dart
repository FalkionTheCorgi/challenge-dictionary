import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB{

  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {

    if(_database != null) return _database;

    return await _initDatabase();

  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'coodesh_challenge.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }
  _onCreate(db, version) async{
    await db.execute(_history);
    await db.execute(_favorite);
    await db.execute(_wordDescription);
    await db.execute(_meaning);
  }

  String get _history => '''
    CREATE TABLE history(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      word TEXT
    );
    ''';

  String get _favorite => '''
    CREATE TABLE favorite(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      word TEXT
    );
    ''';

  String get _wordDescription => '''
    CREATE TABLE word_description(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      word TEXT,
      pronunciation TEXT,
      id_meaning TEXT
    );
    ''';

  String get _meaning => '''
    CREATE TABLE meaning(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      meaning TEXT,
      fk_word_description TEXT
    );
    ''';
    


}