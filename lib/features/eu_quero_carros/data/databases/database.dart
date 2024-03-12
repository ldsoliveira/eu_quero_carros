import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  static const tableName = 'reservas';

  factory LocalDatabase() {
    return _instance;
  }

  LocalDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    final path = join(await getDatabasesPath(), 'reservas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      singleInstance: true,
    );
  }

  Future _onCreate(Database db, int version) async {
    const query = """CREATE TABLE IF NOT EXISTS $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      carro_id INTEGER NOT NULL,
      modelo_id INTEGER NOT NULL,
      email_interessado TEXT NOT NULL,
      nome TEXT NOT NULL,
      timestamp_criacao INTEGER NOT NULL
    );""";

    db.execute(query);
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}