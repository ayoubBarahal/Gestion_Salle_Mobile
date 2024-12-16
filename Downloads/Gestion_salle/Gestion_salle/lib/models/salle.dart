class Salle {
  int? idSalle;
  String nomSalle;
  String localisationSalle;
  String typeSalle;
  int capaciteSalle;
  int? idResp;

  Salle({
    this.idSalle,
    required this.nomSalle,
    required this.localisationSalle,
    required this.typeSalle,
    required this.capaciteSalle,
    this.idResp,
  });

  // Conversion d'une salle en map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id_salle': idSalle,
      'nom_salle': nomSalle,
      'localisation_salle': localisationSalle,
      'type_salle': typeSalle,
      'capacite_salle': capaciteSalle,
      'id_resp': idResp,
    };
  }

  // Création d'une salle à partir d'une map SQLite
  factory Salle.fromMap(Map<String, dynamic> map) {
    return Salle(
      idSalle: map['id_salle'],
      nomSalle: map['nom_salle'],
      localisationSalle: map['localisation_salle'],
      typeSalle: map['type_salle'],
      capaciteSalle: map['capacite_salle'],
      idResp: map['id_resp'],
    );
  }
}
