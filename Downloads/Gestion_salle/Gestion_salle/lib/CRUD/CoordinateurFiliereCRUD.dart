import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/coordinateur_filiere.dart';

class CoordinateurFiliereDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Méthode pour créer un coordinateur
  Future<int> createCoordinateur(CoordinateurFiliere coord) async {
    final db = await _dbHelper.database;
    return await db.insert('Coordinateur_Filiere', coord.toMap());
  }

  // Méthode pour récupérer tous les coordinateurs
  Future<List<CoordinateurFiliere>> getAllCoordinateurs() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Coordinateur_Filiere');
    return List.generate(maps.length, (index) {
      return CoordinateurFiliere.fromMap(maps[index]);
    });
  }

  // Méthode pour récupérer un coordinateur par son id
  Future<CoordinateurFiliere?> getCoordinateurById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Coordinateur_Filiere',
      where: 'id_coord = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CoordinateurFiliere.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Méthode pour mettre à jour un coordinateur
  Future<int> updateCoordinateur(CoordinateurFiliere coord) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Coordinateur_Filiere',
      coord.toMap(),
      where: 'id_coord = ?',
      whereArgs: [coord.idCoord],
    );
  }

  // Méthode pour supprimer un coordinateur par son id
  Future<int> deleteCoordinateur(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Coordinateur_Filiere',
      where: 'id_coord = ?',
      whereArgs: [id],
    );
  }
}
