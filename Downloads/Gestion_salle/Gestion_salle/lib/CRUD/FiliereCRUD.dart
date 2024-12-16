import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/filiere.dart';

class FiliereDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Méthode pour créer une nouvelle Filière
  Future<int> createFiliere(Filiere filiere) async {
    final db = await _dbHelper.database;
    return await db.insert('Filiere', filiere.toMap());
  }

  // Méthode pour récupérer toutes les Filières
  Future<List<Filiere>> getAllFiliere() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Filiere');
    return maps.map((map) => Filiere.fromMap(map)).toList();
  }

  // Méthode pour récupérer une Filière par son ID
  Future<Filiere?> getFiliereById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
    await db.query('Filiere', where: 'id_fil = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Filiere.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Méthode pour mettre à jour une Filière existante
  Future<int> updateFiliere(Filiere filiere) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Filiere',
      filiere.toMap(),
      where: 'id_fil = ?',
      whereArgs: [filiere.idFil],
    );
  }

  // Méthode pour supprimer une Filière
  Future<int> deleteFiliere(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Filiere', where: 'id_fil = ?', whereArgs: [id]);
  }
}
