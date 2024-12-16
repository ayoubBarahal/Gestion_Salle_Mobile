class LiberationDef {
  int? idLibDef; // Identifiant de la libération définitive
  String libelleD;  // Libelle de la libération définitive (par exemple, un code ou une description)
  String DateLib;
  int? idRes;     // Identifiant de la réservation associée
  int? idProf;   // Identifiant du professeur qui a fait la libération (référence à Professeur)

  LiberationDef({
    this.idLibDef,
    required this.libelleD,
    required this.DateLib,
    this.idRes,
    this.idProf,
  });

  // Conversion de l'objet en une Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id_libdef': idLibDef,
      'libelle_d': libelleD,
      'DateLib':DateLib,
      'id_res': idRes,
      'id_prof': idProf,
    };
  }

  // Création d'un objet LiberationDef à partir d'une Map (récupérée de SQLite)
  factory LiberationDef.fromMap(Map<String, dynamic> map) {
    return LiberationDef(
      idLibDef: map['id_libdef'],
      libelleD: map['libelle_d'],
      DateLib: map['DateLib'],
      idRes: map['id_res'],
      idProf: map['id_prof'],
    );
  }
}
