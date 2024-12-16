import 'package:flutter/material.dart';
import '../CRUD/reservationCRUD.dart';


class SurchargePage extends StatefulWidget {
  @override
  _SurchargePageState createState() => _SurchargePageState();
}
class _SurchargePageState extends State<SurchargePage> {
  final ReservationDao _reservationDao = ReservationDao();
  List<Map<String, dynamic>> _reservations = [];
  @override
  void initState() {
    super.initState();
    _loadReservations();
  }
  Future<void> _loadReservations() async {
    var reservations = await _reservationDao.getReservationsDetails();
    setState(() {
      _reservations = reservations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des Surcharges de Réservation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _reservations.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _reservations.length,
          itemBuilder: (context, index) {
            var reservation = _reservations[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text("Salle: ${reservation['nom_salle']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Filère: ${reservation['nom_filiere']}"),
                    Text("Matière: ${reservation['nom_matiere']}"),
                    Text("Créneau: ${reservation['description_crenau']}"),
                    Text("Date début: ${reservation['date_debut']}"),
                    Text("Date fin: ${reservation['date_fin']}"),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    var reservationId = reservation['id'];
                    await _reservationDao.deleteReservation(reservationId);
                    _loadReservations();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
