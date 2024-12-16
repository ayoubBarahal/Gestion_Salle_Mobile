import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/salle.dart';

class SalleDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> createSalle(Salle salle) async {
    final db = await _dbHelper.database;
    return await db.insert('Salle', salle.toMap());
  }

  Future<List<Salle>> getAllSalles() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Salle');
    return maps.map((map) => Salle.fromMap(map)).toList();
  }

  Future<Salle?> getSalleById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
    await db.query('Salle', where: 'id_salle = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Salle.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateSalle(Salle salle) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Salle',
      salle.toMap(),
      where: 'id_salle = ?',
      whereArgs: [salle.idSalle],
    );
  }

  Future<int> deleteSalle(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Salle', where: 'id_salle = ?', whereArgs: [id]);
  }
}
