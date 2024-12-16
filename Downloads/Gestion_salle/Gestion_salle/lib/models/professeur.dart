class Professeur {
  int? idProf;
  String nomProf;
  String prenomProf;
  String mopProf;
  String typeProf;
  String emailProf;
  String telProf;
  int idMat;

  Professeur({
    this.idProf,
    required this.nomProf,
    required this.prenomProf,
    required this.mopProf,
    required this.typeProf,
    required this.emailProf,
    required this.telProf,
    required this.idMat,
  });

  // Convertir un objet Professeur en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id_prof': idProf,
      'nom_prof': nomProf,
      'prenom_prof': prenomProf,
      'mop_prof': mopProf,
      'type_prof': typeProf,
      'email_prof': emailProf,
      'tel_prof': telProf,
      'id_mat': idMat,
    };
  }

  // Créer un objet Professeur à partir d'une Map SQLite
  factory Professeur.fromMap(Map<String, dynamic> map) {
    return Professeur(
      idProf: map['id_prof'],
      nomProf: map['nom_prof'],
      prenomProf: map['prenom_prof'],
      mopProf: map['mop_prof'],
      typeProf: map['type_prof'],
      emailProf: map['email_prof'],
      telProf: map['tel_prof'],
      idMat: map['id_mat'],
    );
  }
}
