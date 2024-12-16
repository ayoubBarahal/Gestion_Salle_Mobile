import 'package:sqflite/sqflite.dart';
import '../database/DatabaseHelper.dart';
import '../models/reservation.dart';

class ReservationDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Créer une réservation
  Future<int> createReservation(Reservation reservation) async {
    final db = await _dbHelper.database;
    return await db.insert('Reservation', reservation.toMap());
  }

  // Récupérer toutes les réservations
  Future<List<Reservation>> getAllReservations() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Reservation');
    return maps.map((map) => Reservation.fromMap(map)).toList();
  }

  // Récupérer une réservation par ID
  Future<Reservation?> getReservationById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
    await db.query('Reservation', where: 'id_res = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Reservation.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Mettre à jour une réservation
  Future<int> updateReservation(Reservation reservation) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Reservation',
      reservation.toMap(),
      where: 'id_res = ?',
      whereArgs: [reservation.idRes],
    );
  }

  // Supprimer une réservation par son ID
  Future<int> deleteReservation(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('Reservation', where: 'id_res = ?', whereArgs: [id]);
  }

  // Récupérer les détails des réservations avec jointures
  Future<List<Map<String, dynamic>>> getReservationsDetails() async {
    final db = await _dbHelper.database;

    // Requête SQL pour récupérer les détails des réservations
    final result = await db.rawQuery('''
      SELECT 
        r.id_res AS id,
        f.niveau AS nom_filiere,
        m.libelle_mat AS nom_matiere,
        s.nom_salle AS nom_salle,
        c.crenauDes AS description_crenau,
        r.dateDebut AS date_debut,
        r.dateFin AS date_fin
      FROM Reservation r
      LEFT JOIN Filiere f ON r.id_fil = f.id_fil
      LEFT JOIN Professeur p ON r.id_prof = p.id_prof
      LEFT JOIN Matiere m ON p.id_mat = m.id_mat
      LEFT JOIN Crenau c ON r.id_crenau = c.id_crenau
      LEFT JOIN Salle s ON c.id_salle = s.id_salle;
    ''');

    return result;
  }
}
