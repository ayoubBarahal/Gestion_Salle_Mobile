class Filiere {
  int? idFil;
  int effectif;
  String niveau;
  int? idCoord;

  Filiere({
    this.idFil,
    required this.effectif,
    required this.niveau,
    this.idCoord,
  });
  Map<String, dynamic> toMap() {
    return {
      'id_fil': idFil,
      'effectif': effectif,
      'niveau': niveau,
      'id_coord': idCoord,
    };
  }
  
  factory Filiere.fromMap(Map<String, dynamic> map) {
    return Filiere(
      idFil: map['id_fil'],
      effectif: map['effectif'],
      niveau: map['niveau'],
      idCoord: map['id_coord'],
    );
  }
}
