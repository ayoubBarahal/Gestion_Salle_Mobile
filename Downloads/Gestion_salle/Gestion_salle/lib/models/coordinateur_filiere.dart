class CoordinateurFiliere {
  int? idCoord;
  String nomCoord;
  String prenomCoord;
  String mopCoord;
  String typeCoord;
  String emailCoord;
  String telCoord;

  // Constructeur de la classe
  CoordinateurFiliere({
    this.idCoord,
    required this.nomCoord,
    required this.prenomCoord,
    required this.mopCoord,
    required this.typeCoord,
    required this.emailCoord,
    required this.telCoord,
  });

  // Convertir un objet CoordinateurFiliere en Map (pour SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id_coord': idCoord,
      'nom_coord': nomCoord,
      'prenom_coord': prenomCoord,
      'mop_coord': mopCoord,
      'type_coord': typeCoord,
      'email_coord': emailCoord,
      'tel_coord': telCoord,
    };
  }

  // Convertir une map en un objet CoordinateurFiliere
  factory CoordinateurFiliere.fromMap(Map<String, dynamic> map) {
    return CoordinateurFiliere(
      idCoord: map['id_coord'],
      nomCoord: map['nom_coord'],
      prenomCoord: map['prenom_coord'],
      mopCoord: map['mop_coord'],
      typeCoord: map['type_coord'],
      emailCoord: map['email_coord'],
      telCoord: map['tel_coord'],
    );
  }
}
