import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../CRUD/FiliereCRUD.dart.';
import '../CRUD/matiereCRUD.dart';
import '../CRUD/creanuCRUD.dart';
import '../CRUD/salleCRUD.dart';
import '../CRUD/reservationCRUD.dart';
import '../models/filiere.dart';
import '../models/matiere.dart';
import '../models/crenau.dart';
import '../models/salle.dart';
import '../models/reservation.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _dateDebutController = TextEditingController();
  final _dateFinController = TextEditingController();
  final _filiereDao = FiliereDao();
  final _matiereDao = MatiereDao();
  final _crenauDao = CrenauCRUD();
  final _salleDao = SalleDao();
  final _reservationDao = ReservationDao();

  Filiere? _selectedFiliere;
  Matiere? _selectedMatiere;
  Crenau? _selectedCrenau;
  DateTime? _dateDebut;
  DateTime? _dateFin;
  Salle? _selectedSalle;

  List<Filiere> _filieres = [];
  List<Matiere> _matieres = [];
  List<Crenau> _crenaux = [];
  List<Salle> _sallesDisponibles = [];

  @override
  void initState() {
    super.initState();
    _loadFilieres();
    _loadMatieres();
    _loadCrenaux();
  }

  Future<void> _loadFilieres() async {
    var filieres = await _filiereDao.getAllFiliere();
    setState(() {
      _filieres = filieres;
    });
  }

  Future<void> _loadMatieres() async {
    var matieres = await _matiereDao.getAllMatieres();
    setState(() {
      _matieres = matieres;
    });
  }

  Future<void> _loadCrenaux() async {
    var crenaux = await _crenauDao.getAllCrenaux();
    setState(() {
      _crenaux = crenaux;
    });
  }

  Future<void> _loadSallesDisponibles() async {
    var salles = await _salleDao.getAllSalles();
    var availableSalles = <Salle>[];

    for (var salle in salles) {
      var reservations = await _reservationDao.getAllReservations();
      bool isAvailable = true;
      for (var reservation in reservations) {
        if (reservation.idCrenau == _selectedCrenau?.idCrenau &&
            reservation.idFil == _selectedFiliere?.idFil) {
          isAvailable = false;
          break;
        }
      }
      if (isAvailable) {
        availableSalles.add(salle);
      }
    }

    setState(() {
      _sallesDisponibles = availableSalles;
    });
  }

  Future<void> _submitReservation() async {
    if (_formKey.currentState!.validate()) {
      if (_dateDebut != null && _dateFin != null) {
        Reservation reservation = Reservation(
          dateDebut: DateFormat('yyyy-MM-dd HH:mm').format(_dateDebut!),
          dateFin: DateFormat('yyyy-MM-dd HH:mm').format(_dateFin!),
          idFil: _selectedFiliere?.idFil,
          idCrenau: _selectedCrenau?.idCrenau,
        );

        var result = await _reservationDao.createReservation(reservation);
        if (result > 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Réservation réussie')));
        }
      }
    }
  }

  Future<void> _selectDateDebut(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateDebut ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateDebut)
      setState(() {
        _dateDebut = picked;
        _dateDebutController.text = DateFormat('yyyy-MM-dd').format(_dateDebut!);
      });
  }

  Future<void> _selectDateFin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateFin ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateFin)
      setState(() {
        _dateFin = picked;
        _dateFinController.text = DateFormat('yyyy-MM-dd').format(_dateFin!);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réservation de Salle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<Filiere>(
                  value: _selectedFiliere,
                  items: _filieres.map((filiere) {
                    return DropdownMenuItem<Filiere>(
                      value: filiere,
                      child: Text(filiere.niveau),
                    );
                  }).toList(),
                  onChanged: (filiere) {
                    setState(() {
                      _selectedFiliere = filiere;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Filière'),
                  validator: (value) => value == null ? 'Sélectionnez une filière' : null,
                ),
                DropdownButtonFormField<Matiere>(
                  value: _selectedMatiere,
                  items: _matieres.map((matiere) {
                    return DropdownMenuItem<Matiere>(
                      value: matiere,
                      child: Text(matiere.libelleMat),
                    );
                  }).toList(),
                  onChanged: (matiere) {
                    setState(() {
                      _selectedMatiere = matiere;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Matière'),
                ),
                DropdownButtonFormField<Crenau>(
                  value: _selectedCrenau,
                  items: _crenaux.map((crenau) {
                    return DropdownMenuItem<Crenau>(
                      value: crenau,
                      child: Text(crenau.crenauDes),
                    );
                  }).toList(),
                  onChanged: (crenau) {
                    setState(() {
                      _selectedCrenau = crenau;
                    });
                    _loadSallesDisponibles();
                  },
                  decoration: InputDecoration(labelText: 'Créneau'),
                  validator: (value) => value == null ? 'Sélectionnez un créneau' : null,
                ),
                TextFormField(
                  controller: _dateDebutController,
                  decoration: InputDecoration(labelText: 'Date de début'),
                  onTap: () => _selectDateDebut(context),
                  readOnly: true,
                ),
                TextFormField(
                  controller: _dateFinController,
                  decoration: InputDecoration(labelText: 'Date de fin'),
                  onTap: () => _selectDateFin(context),
                  readOnly: true,
                ),
                DropdownButtonFormField<Salle>(
                  value: _selectedSalle,
                  items: _sallesDisponibles.map((salle) {
                    return DropdownMenuItem<Salle>(
                      value: salle,
                      child: Text(salle.nomSalle),
                    );
                  }).toList(),
                  onChanged: (salle) {
                    setState(() {
                      _selectedSalle = salle;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Salle disponible'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitReservation,
                  child: Text("Réserver"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
