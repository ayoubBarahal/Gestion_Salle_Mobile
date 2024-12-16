import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/Emploie.dart';

class EmploieCRUD {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Créer un emploi (ajouter une entrée dans la table Emploie)
  Future<int> createEmploie(Emploie emploi) async {
    final db = await _dbHelper.database;
    return await db.insert('Emploie', emploi.toMap());
  }

  // Récupérer tous les emplois
  Future<List<Emploie>> getAllEmplois() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Emploie');
    return maps.map((map) => Emploie.fromMap(map)).toList();
  }

  // Récupérer un emploi par son id
  Future<Emploie?> getEmploieById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
    await db.query('Emploie', where: 'id_emploie = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Emploie.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Mettre à jour un emploi existant
  Future<int> updateEmploie(Emploie emploi) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Emploie',
      emploi.toMap(),
      where: 'id_emploie = ?',
      whereArgs: [emploi.idEmploie],
    );
  }

  // Supprimer un emploi par son id
  Future<int> deleteEmploie(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Emploie', where: 'id_emploie = ?', whereArgs: [id]);
  }
}
