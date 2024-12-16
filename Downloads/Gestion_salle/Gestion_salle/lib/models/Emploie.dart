class Emploie {
  int? idEmploie;
  String descriptionEmploie;
  int? idCoord;

  Emploie({
    this.idEmploie,
    required this.descriptionEmploie,
    this.idCoord,
  });

  // Convertir un objet Emploie en map (pour insertion dans SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id_emploie': idEmploie,
      'des_emploie': descriptionEmploie,
      'id_coord': idCoord,
    };
  }

  // Convertir une map SQLite en objet Emploie
  factory Emploie.fromMap(Map<String, dynamic> map) {
    return Emploie(
      idEmploie: map['id_emploie'],
      descriptionEmploie: map['des_emploie'],
      idCoord: map['id_coord'],
    );
  }
}
