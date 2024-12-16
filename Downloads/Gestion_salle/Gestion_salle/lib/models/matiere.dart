class Matiere {
  int? idMat;
  String libelleMat;
  int totalHoraire;
  int? idCoord;

  Matiere({
    this.idMat,
    required this.libelleMat,
    required this.totalHoraire,
    this.idCoord,
  });

  // Convertir un objet Matiere en Map pour l'insertion dans la base de données
  Map<String, dynamic> toMap() {
    return {
      'id_mat': idMat,
      'libelle_mat': libelleMat,
      'total_horaire': totalHoraire,
      'id_coord': idCoord,
    };
  }

  // Créer un objet Matiere à partir d'un Map récupéré de la base de données
  factory Matiere.fromMap(Map<String, dynamic> map) {
    return Matiere(
      idMat: map['id_mat'],
      libelleMat: map['libelle_mat'],
      totalHoraire: map['total_horaire'],
      idCoord: map['id_coord'],
    );
  }
}
