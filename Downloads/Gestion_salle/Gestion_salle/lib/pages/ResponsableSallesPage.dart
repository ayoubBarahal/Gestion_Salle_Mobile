import 'package:flutter/material.dart';
import '../crud/salleCRUD.dart';
import '../models/salle.dart';

class ResponsableSallesPage extends StatefulWidget {
  @override
  _ResponsableSallesPageState createState() => _ResponsableSallesPageState();
}

class _ResponsableSallesPageState extends State<ResponsableSallesPage> {
  final SalleDao _salleDao = SalleDao();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomSalleController = TextEditingController();
  final TextEditingController _localisationSalleController = TextEditingController();
  final TextEditingController _capaciteSalleController = TextEditingController();
  String _selectedTypeSalle = 'Cours';

  Future<void> _ajouterSalle() async {
    if (_formKey.currentState!.validate()) {
      Salle salle = Salle(
        nomSalle: _nomSalleController.text,
        localisationSalle: _localisationSalleController.text,
        capaciteSalle: int.parse(_capaciteSalleController.text),
        typeSalle: _selectedTypeSalle,
      );
      await _salleDao.createSalle(salle);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Salle ajoutée avec succès')));
      _clearFields();
    }
  }

  Future<void> _supprimerSalle(int idSalle) async {
    await _salleDao.deleteSalle(idSalle);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Salle supprimée')));
    _clearFields();
  }

  void _clearFields() {
    _nomSalleController.clear();
    _localisationSalleController.clear();
    _capaciteSalleController.clear();
    setState(() {
      _selectedTypeSalle = 'Cours';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsable des Salles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomSalleController,
                  decoration: InputDecoration(labelText: 'Nom de la salle'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le nom de la salle est requis';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _localisationSalleController,
                  decoration: InputDecoration(labelText: 'Localisation de la salle'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La localisation est requise';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _capaciteSalleController,
                  decoration: InputDecoration(labelText: 'Capacité de la salle'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La capacité est requise';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Veuillez entrer un nombre valide';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedTypeSalle,
                  decoration: InputDecoration(labelText: 'Type de salle'),
                  items: ['Cours', 'TP', 'TD'].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTypeSalle = newValue!;
                    });
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: _ajouterSalle,
                      child: Text('Ajouter'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        int idSalle = 1;
                        _supprimerSalle(idSalle);
                      },
                      child: Text('Supprimer'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
