import 'package:flutter/material.dart';
import 'liberation_page.dart';
import 'ReservationPage.dart';
import 'SurchargePage.dart';
class ProfesseurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Salles - Professeur'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeatureCard(
              context,
              title: "Libération de Salle",
              description:
              "Libérez une salle de façon définitive ou temporaire selon vos besoins.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LiberationPage()),
                );
              },
            ),
            _buildFeatureCard(
              context,
              title: "Demande de Réservation de Salle",
              description:
              "Effectuez une demande de réservation pour un cours, TP ou TD.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ReservationPage()),
                );
              },
            ),
            _buildFeatureCard(
              context,
              title: "Gestion des Surcharges de Réservation",
              description:
              "Consultez les demandes en attente et gérez la file d’attente selon le FIFO.",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SurchargePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required String title,
        required String description,
        required VoidCallback onTap}) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
