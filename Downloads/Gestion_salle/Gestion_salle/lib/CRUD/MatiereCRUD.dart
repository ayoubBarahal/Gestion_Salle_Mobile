import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/matiere.dart';

class MatiereDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Créer une nouvelle matière dans la base de données
  Future<int> createMatiere(Matiere matiere) async {
    final db = await _dbHelper.database;
    return await db.insert('Matiere', matiere.toMap());
  }

  // Récupérer toutes les matières
  Future<List<Matiere>> getAllMatieres() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Matiere');

    return List.generate(maps.length, (i) {
      return Matiere.fromMap(maps[i]);
    });
  }

  // Récupérer une matière par son ID
  Future<Matiere?> getMatiereById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Matiere',
      where: 'id_mat = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Matiere.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Mettre à jour une matière
  Future<int> updateMatiere(Matiere matiere) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Matiere',
      matiere.toMap(),
      where: 'id_mat = ?',
      whereArgs: [matiere.idMat],
    );
  }

  // Supprimer une matière par son ID
  Future<int> deleteMatiere(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Matiere',
      where: 'id_mat = ?',
      whereArgs: [id],
    );
  }
}
