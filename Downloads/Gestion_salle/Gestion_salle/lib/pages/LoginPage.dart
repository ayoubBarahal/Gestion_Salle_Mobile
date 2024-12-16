import 'package:flutter/material.dart';
import '../CRUD/professeurCRUD.dart';
import '../CRUD/responsableSallesCRUD.dart';
import '../models/professeur.dart';
import '../models/responsable_salles.dart';
import 'professeurPage.dart';
import 'responsableSallesPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ProfesseurDao _professeurDao = ProfesseurDao();
  final ResponsableSallesDao _responsableSallesDao = ResponsableSallesDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page de Connexion"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un email.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un mot de passe.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLogin,
                child: Text("Se connecter"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      bool isProfesseur = await _checkIfProfesseur(email, password);
      bool isResponsableSalle = await _checkIfResponsableSalle(email, password);

      if (isProfesseur) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfesseurPage()),
        );
      } else if (isResponsableSalle) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResponsableSallesPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Email ou mot de passe incorrect."),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<bool> _checkIfProfesseur(String email, String password) async {
    var professeurs = await _professeurDao.getProfesseurByEmailAndPassword(email, password);
    return professeurs.isNotEmpty;
  }

  Future<bool> _checkIfResponsableSalle(String email, String password) async {
    var responsables = await _responsableSallesDao.getResponsableSallesByEmailAndPassword(email, password);
    return responsables.isNotEmpty;
  }
}
