class Crenau {
  int? idCrenau;
  String crenauDes;
  bool disponibiliteSalle;
  int? idSalle;

  Crenau({
    this.idCrenau,
    required this.crenauDes,
    required this.disponibiliteSalle,
    this.idSalle,
  });

  // Convertir un objet Crenau en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id_crenau': idCrenau,
      'crenauDes': crenauDes,
      'disponibilite_salle': disponibiliteSalle ? 1 : 0, // SQLite utilise 1/0 pour les booléens
      'id_salle': idSalle,
    };
  }

  // Créer un objet Crenau à partir d'un Map SQLite
  factory Crenau.fromMap(Map<String, dynamic> map) {
    return Crenau(
      idCrenau: map['id_crenau'],
      crenauDes: map['crenauDes'],
      disponibiliteSalle: map['disponibilite_salle'] == 1,
      idSalle: map['id_salle'],
    );
  }
}
