import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/responsable_salles.dart';

class ResponsableSallesDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Méthode pour insérer un ResponsableSalles dans la base de données
  Future<int> createResponsable(ResponsableSalles responsable) async {
    final db = await _dbHelper.database;
    return await db.insert('Responsable_salles', responsable.toMap());
  }

  // Méthode pour récupérer tous les ResponsablesSalles
  Future<List<ResponsableSalles>> getAllResponsables() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Responsable_salles');
    return List.generate(maps.length, (i) {
      return ResponsableSalles.fromMap(maps[i]);
    });
  }

  // Méthode pour récupérer un ResponsableSalles par son ID
  Future<ResponsableSalles?> getResponsableById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Responsable_salles',
      where: 'id_resp = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ResponsableSalles.fromMap(maps.first);
    } else {
      return null;  // Aucun ResponsableSalles trouvé avec cet ID
    }
  }

  // Méthode pour mettre à jour un ResponsableSalles
  Future<int> updateResponsable(ResponsableSalles responsable) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Responsable_salles',
      responsable.toMap(),
      where: 'id_resp = ?',
      whereArgs: [responsable.idResp],
    );
  }

  // Méthode pour supprimer un ResponsableSalles par son ID
  Future<int> deleteResponsable(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Responsable_salles',
      where: 'id_resp = ?',
      whereArgs: [id],
    );
  }

  // Vérifier si un responsable des salles existe avec l'email et le mot de passe
  Future<List<ResponsableSalles>> getResponsableByEmailAndPassword(String email, String password) async {
    final db = await _dbHelper.database;

    // Requête SQL pour récupérer le responsable des salles par email et mot de passe
    final List<Map<String, dynamic>> maps = await db.query(
      'Responsable_salles',
      where: 'email_resp = ? AND mop_resp = ?',
      whereArgs: [email, password],
    );

    // Retourner la liste des responsables des salles (vide si aucun résultat)
    return maps.map((map) => ResponsableSalles.fromMap(map)).toList();
  }
}
