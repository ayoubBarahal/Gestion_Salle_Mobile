class ResponsableSalles {
  int? idResp;
  String nomResp;
  String prenomResp;
  String mopResp;
  String typeResp;
  String emailResp;
  String telResp;

  // Constructeur
  ResponsableSalles({
    this.idResp,
    required this.nomResp,
    required this.prenomResp,
    required this.mopResp,
    required this.typeResp,
    required this.emailResp,
    required this.telResp,
  });

  // Méthode pour convertir l'objet ResponsableSalles en une Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id_resp': idResp,
      'nom_resp': nomResp,
      'prenom_resp': prenomResp,
      'mop_resp': mopResp,
      'type_resp': typeResp,
      'email_resp': emailResp,
      'tel_resp': telResp,
    };
  }

  // Méthode pour créer un ResponsableSalles à partir d'une Map (extraite de la base de données)
  factory ResponsableSalles.fromMap(Map<String, dynamic> map) {
    return ResponsableSalles(
      idResp: map['id_resp'],
      nomResp: map['nom_resp'],
      prenomResp: map['prenom_resp'],
      mopResp: map['mop_resp'],
      typeResp: map['type_resp'],
      emailResp: map['email_resp'],
      telResp: map['tel_resp'],
    );
  }
}
