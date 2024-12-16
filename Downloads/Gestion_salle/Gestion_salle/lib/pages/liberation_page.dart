import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/reservation.dart';
import '../models/liberation_def.dart';
import '../models/liberationexp.dart';
import '../CRUD/Liberation_defCRUD.dart';
import '../CRUD/LiberationexpCRUD.dart';
import '../CRUD/ReservationCRUD.dart';
import '../CRUD/ProfesseurCRUD.dart';
import '../CRUD/MatiereCRUD.dart';

class LiberationPage extends StatefulWidget {
  @override
  _LiberationPageState createState() => _LiberationPageState();
}

class _LiberationPageState extends State<LiberationPage> {
  final ReservationDao _reservationDao = ReservationDao();
  final LiberationDefDao _liberationDefDao = LiberationDefDao();
  final LiberationExpDao _liberationExpDao = LiberationExpDao();
  final ProfesseurDao _professeurDao = ProfesseurDao(); // Instance de ProfesseurDao
  final MatiereDao _matiereDao = MatiereDao(); // Instance de MatiereDao

  late Future<List<Map<String, dynamic>>> _reservationsDetails;

  @override
  void initState() {
    super.initState();
    // Charger les détails des réservations
    _reservationsDetails = _reservationDao.getReservationsDetails();
  }

  // Formatage de la date
  String _formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(parsedDate);
  }

  // Fonction pour libérer définitivement une salle
  void _libererDefinitivement(Reservation reservation) async {
    // Vérifier si la réservation a bien terminé sa charge horaire (par exemple : date actuelle > dateFin)
    DateTime dateFin = DateTime.parse(reservation.dateFin);
    if (DateTime.now().isAfter(dateFin)) {
      // Récupérer le professeur associé à la réservation
      final professeur = await _professeurDao.getProfesseurById(reservation.idProf!);

      if (professeur != null) {
        // Récupérer la matière du professeur (via le champ 'id_mat' dans Professeur)
        final matiere = await _matiereDao.getMatiereById(professeur.idMat!);

        if (matiere != null) {
          // Créer le libellé sous la forme "Fin du cours (Libelle matiere)"
          String libelleD = "Fin du cours (${matiere.libelleMat})";

          // Créer l'objet LiberationDef avec le libelleD
          final liberationDef = LiberationDef(
            idRes: reservation.idRes!,
            DateLib: DateTime.now().toIso8601String(),
            libelleD: libelleD, // Passer le libellé formaté ici
          );

          // Ajouter à la libération définitive dans la base de données
          await _liberationDefDao.createLiberationDef(liberationDef);

          // Supprimer la réservation de la base de données
          await _reservationDao.deleteReservation(reservation.idRes!);

          // Rafraîchir la liste des réservations
          setState(() {
            _reservationsDetails = _reservationDao.getReservationsDetails();
          });


          // Notification automatique si libération non effectuée
          _envoyerNotificationProfResponsable(reservation.idRes!);
        } else {
          // Gérer le cas où la matière n'a pas été trouvée
          print("Matière non trouvée pour le professeur.");
        }
      } else {
        // Gérer le cas où le professeur n'a pas été trouvé
        print("Professeur non trouvé.");
      }
    }
  }


  // Fonction pour libérer exceptionnellement une salle
  void _libererExceptionnellement(int idRes, String dateDebut, String dateFin) async {
    // Récupérer la réservation associée à l'ID
    final reservation = await _reservationDao.getReservationById(idRes);

    if (reservation != null) {
      // Vérifier si le professeur est null avant d'accéder à ses propriétés
      final professeur = await _professeurDao.getProfesseurById(reservation.idProf!);

      if (professeur != null) {
        // Récupérer la matière associée au professeur
        final matiere = await _matiereDao.getMatiereById(professeur.idMat);

        if (matiere != null) {
          // Créer le LibelleE (par exemple "Fin du cours: Nom de la matière")
          String libelleE = 'Fin du cours: ${matiere.libelleMat}';

          // Ajouter une libération exceptionnelle à la base de données avec LibelleE
          final liberationExp = LiberationExp(
            idRes: idRes,
            dateDebut: dateDebut,
            dateFin: dateFin,
            libelleE: libelleE,  // Ajout du libelleE
          );
          await _liberationExpDao.createLiberationExp(liberationExp);

          // Rafraîchir la liste des réservations
          setState(() {
            _reservationsDetails = _reservationDao.getReservationsDetails();
          });
        } else {
          print('Matière non trouvée pour le professeur.');
        }
      } else {
        print('Professeur non trouvé pour cette réservation.');
      }
    } else {
      print('Réservation non trouvée pour l\'ID donné.');
    }
  }






  // Vérification de la libération automatique
  // Effectuer la libération définitive automatiquement
  // Effectuer la libération définitive automatiquement
  void _libererDefinitivementAutomatique(int reservationId) async {
    // Récupérer la réservation complète en utilisant l'ID
    final reservation = await _reservationDao.getReservationById(reservationId);

    if (reservation != null) {
      // Appeler la méthode de libération définitive avec la réservation complète
      _libererDefinitivement(reservation);
    } else {
      print('Réservation non trouvée pour l\'ID donné.');
    }
  }



  // Affichage de la page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libération des Salles'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _reservationsDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune réservation trouvée.'));
          }

          final reservationsDetails = snapshot.data!;

          return ListView(
            children: [
              DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Filière')),
                  DataColumn(label: Text('Matière')),
                  DataColumn(label: Text('Salle')),
                  DataColumn(label: Text('Créneau')),
                  DataColumn(label: Text('Date début')),
                  DataColumn(label: Text('Date fin')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: reservationsDetails.map((reservation) {
                  return DataRow(cells: [
                    DataCell(Text(reservation['id'].toString())),
                    DataCell(Text(reservation['nom_filiere'])),
                    DataCell(Text(reservation['nom_matiere'])),
                    DataCell(Text(reservation['nom_salle'])),
                    DataCell(Text(reservation['description_crenau'])),
                    DataCell(Text(_formatDate(reservation['date_debut']))),
                    DataCell(Text(_formatDate(reservation['date_fin']))),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _libererDefinitivement(reservation['id']);
                          },
                          tooltip: 'Libération définitive',
                        ),
                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            _libererExceptionnellement(
                              reservation['id'],
                              reservation['date_debut'],
                              reservation['date_fin'],
                            );
                          },
                          tooltip: 'Libération exceptionnelle',
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showLiberationForm(context);
                  },
                  child: Text('Demander une libération exceptionnelle'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Fonction pour afficher le formulaire de libération
  void _showLiberationForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _idController = TextEditingController();
    final TextEditingController _dateDebutController = TextEditingController();
    final TextEditingController _dateFinController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Demander une libération exceptionnelle'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: 'ID de la réservation'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un ID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateDebutController,
                  decoration: InputDecoration(labelText: 'Date de début'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la date de début';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateFinController,
                  decoration: InputDecoration(labelText: 'Date de fin'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer la date de fin';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final reservation = Reservation(
                    idRes: int.parse(_idController.text),
                    dateDebut: _dateDebutController.text,
                    dateFin: _dateFinController.text,
                  );

                  // Appeler la méthode de libération exceptionnelle avec les dates
                  _libererExceptionnellement(
                    reservation.idRes!,
                    reservation.dateDebut,
                    reservation.dateFin,
                  );

                  Navigator.of(context).pop();
                }
              },
              child: Text('Libérer'),
            ),
          ],
        );
      },
    );
  }


  // Simulation de notification (remplacer avec la vraie logique de notification)
  void _envoyerNotificationProfResponsable(int idRes) {
    // Implémenter la logique de notification du professeur et du responsable
    print("Notification envoyée pour la libération de la réservation $idRes");
  }
}
