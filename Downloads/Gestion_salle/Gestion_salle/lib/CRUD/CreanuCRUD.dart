import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/crenau.dart';

class CrenauCRUD {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> createCrenau(Crenau crenau) async {
    final db = await _dbHelper.database;
    return await db.insert('Crenau', crenau.toMap());
  }

  Future<List<Crenau>> getAllCrenaux() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Crenau');
    return maps.map((map) => Crenau.fromMap(map)).toList();
  }

  // Méthode pour récupérer un créneau par ID
  Future<Crenau?> getCrenauById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
    await db.query('Crenau', where: 'id_crenau = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Crenau.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Méthode pour mettre à jour un créneau
  Future<int> updateCrenau(Crenau crenau) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Crenau',
      crenau.toMap(),
      where: 'id_crenau = ?',
      whereArgs: [crenau.idCrenau],
    );
  }

  // Méthode pour supprimer un créneau
  Future<int> deleteCrenau(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Crenau', where: 'id_crenau = ?', whereArgs: [id]);
  }

  // Méthode pour récupérer tous les créneaux d'une salle spécifique
  Future<List<Crenau>> getCrenauxBySalleId(int idSalle) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Crenau',
      where: 'id_salle = ?',
      whereArgs: [idSalle],
    );
    return maps.map((map) => Crenau.fromMap(map)).toList();
  }
}
