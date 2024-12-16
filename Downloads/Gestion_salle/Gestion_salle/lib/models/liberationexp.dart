class LiberationExp {
  int? idLibexp;
  String libelleE;
  String dateDebut;
  String dateFin;
  int? idProf;
  int? idRes;

  LiberationExp({
    this.idLibexp,
    required this.libelleE,
    required this.dateDebut,
    required this.dateFin,
    this.idProf,
    this.idRes,
  });

  // Convertir une instance de LiberationExp en map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id_libexp': idLibexp,
      'libelle_e': libelleE,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
      'id_prof': idProf,
      'id_res': idRes,
    };
  }

  // Créer une instance de LiberationExp à partir d'un map (SQLite)
  factory LiberationExp.fromMap(Map<String, dynamic> map) {
    return LiberationExp(
      idLibexp: map['id_libexp'],
      libelleE: map['libelle_e'],
      dateDebut: map['dateDebut'],
      dateFin: map['dateFin'],
      idProf: map['id_prof'],
      idRes: map['id_res'],
    );
  }
}
