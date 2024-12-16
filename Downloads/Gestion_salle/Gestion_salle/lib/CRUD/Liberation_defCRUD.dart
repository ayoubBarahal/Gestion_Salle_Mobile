import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/liberation_def.dart';

class LiberationDefDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Créer une nouvelle libération définitive
  Future<int> createLiberationDef(LiberationDef liberationDef) async {
    final db = await _dbHelper.database;
    return await db.insert('Liberation_Def', liberationDef.toMap());
  }

  // Récupérer toutes les libérations définitives
  Future<List<LiberationDef>> getAllLiberationsDef() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Liberation_Def');
    return maps.map((map) => LiberationDef.fromMap(map)).toList();
  }

  // Récupérer une libération définitive par ID
  Future<LiberationDef?> getLiberationDefById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Liberation_Def',
      where: 'id_libdef = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return LiberationDef.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Mettre à jour une libération définitive existante
  Future<int> updateLiberationDef(LiberationDef liberationDef) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Liberation_Def',
      liberationDef.toMap(),
      where: 'id_libdef = ?',
      whereArgs: [liberationDef.idLibDef],
    );
  }

  // Supprimer une libération définitive
  Future<int> deleteLiberationDef(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Liberation_Def',
      where: 'id_libdef = ?',
      whereArgs: [id],
    );
  }
}
