import 'package:eu_quero_carros/features/eu_quero_carros/data/databases/database.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/models/reserva_model.dart';
import 'package:sqflite/sqflite.dart';

class ReservasDAO {
  final db = LocalDatabase();

  Future<void> insertReserva(ReservaModel reserva) async {
    final Database database = await db.database;
    await database.insert(
      LocalDatabase.tableName,
      reserva.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ReservaModel>> getReservas() async {
    final Database database = await db.database;
    final List<Map<String, dynamic>> entries = await database.query(LocalDatabase.tableName);
    return entries.map((reserva) => ReservaModel.fromMap(reserva)).toList();
  }

  Future<void> deleteReserva(int id) async {
    final Database database = await db.database;
    await database.delete(
      LocalDatabase.tableName,
      where: 'timestamp_criacao = ?',
      whereArgs: [id],
    );
  }
}