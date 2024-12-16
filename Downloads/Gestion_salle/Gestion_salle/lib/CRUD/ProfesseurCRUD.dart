import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/professeur.dart';

class ProfesseurDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Créer un professeur
  Future<int> createProfesseur(Professeur professeur) async {
    final db = await _dbHelper.database;
    return await db.insert('Professeur', professeur.toMap());
  }

  // Récupérer tous les professeurs
  Future<List<Professeur>> getAllProfesseurs() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Professeur');
    return maps.map((map) => Professeur.fromMap(map)).toList();
  }

  // Récupérer un professeur par son ID
  Future<Professeur?> getProfesseurById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
    await db.query('Professeur', where: 'id_prof = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Professeur.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Mettre à jour un professeur
  Future<int> updateProfesseur(Professeur professeur) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Professeur',
      professeur.toMap(),
      where: 'id_prof = ?',
      whereArgs: [professeur.idProf],
    );
  }

  // Supprimer un professeur par son ID
  Future<int> deleteProfesseur(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Professeur', where: 'id_prof = ?', whereArgs: [id]);
  }

  // Vérifier si un professeur existe avec l'email et le mot de passe
  Future<List<Professeur>> getProfesseurByEmailAndPassword(String email, String password) async {
    final db = await _dbHelper.database;

    // Requête SQL pour récupérer un professeur par email et mot de passe
    final List<Map<String, dynamic>> maps = await db.query(
      'Professeur',
      where: 'email_prof = ? AND mop_prof = ?',
      whereArgs: [email, password],
    );

    // Retourner la liste des professeurs (vide si aucun résultat)
    return maps.map((map) => Professeur.fromMap(map)).toList();
  }
}
