import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/liberationexp.dart';

class LiberationExpDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Création d'un enregistrement de liberation exp
  Future<int> createLiberationExp(LiberationExp liberationExp) async {
    final db = await _dbHelper.database;
    return await db.insert('Liberation_Exp', liberationExp.toMap());
  }

  // Récupérer toutes les libérations exceptionnelles
  Future<List<LiberationExp>> getAllLiberationsExp() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Liberation_Exp');
    return maps.map((map) => LiberationExp.fromMap(map)).toList();
  }

  // Récupérer une libération exceptionnelle par ID
  Future<LiberationExp?> getLiberationExpById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
    await db.query('Liberation_Exp', where: 'id_libexp = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return LiberationExp.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Mise à jour d'une libération exceptionnelle
  Future<int> updateLiberationExp(LiberationExp liberationExp) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Liberation_Exp',
      liberationExp.toMap(),
      where: 'id_libexp = ?',
      whereArgs: [liberationExp.idLibexp],
    );
  }

  // Suppression d'une libération exceptionnelle
  Future<int> deleteLiberationExp(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Liberation_Exp', where: 'id_libexp = ?', whereArgs: [id]);
  }
}
