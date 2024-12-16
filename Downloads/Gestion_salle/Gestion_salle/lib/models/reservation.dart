class Reservation {
  int? idRes;
  String dateDebut;
  String dateFin;
  int? idProf;
  int? idFil;
  int? idCrenau;

  Reservation({
    this.idRes,
    required this.dateDebut,
    required this.dateFin,
    this.idProf,
    this.idFil,
    this.idCrenau,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_res': idRes,
      'dateDebut': dateDebut,
      'dateFin': dateFin,
      'id_prof': idProf,
      'id_fil': idFil,
      'id_crenau': idCrenau,
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      idRes: map['id_res'],
      dateDebut: map['dateDebut'],
      dateFin: map['dateFin'],
      idProf: map['id_prof'],
      idFil: map['id_fil'],
      idCrenau: map['id_crenau'],
    );
  }
}
