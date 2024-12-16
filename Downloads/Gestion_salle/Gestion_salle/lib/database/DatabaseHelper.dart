import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('gestion_salle.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {

    // Table Responsable_salles
    await db.execute(''' 
      CREATE TABLE Responsable_salles (
        id_resp INTEGER PRIMARY KEY AUTOINCREMENT,
        nom_resp CHAR(50),
        prenom_resp CHAR(50),
        mop_resp CHAR(50),
        type_resp CHAR(20),
        email_resp CHAR(100),
        tel_resp CHAR(15)
      );
    ''');

    // Table Coordinateur_Filiere
    await db.execute(''' 
      CREATE TABLE Coordinateur_Filiere (
        id_coord INTEGER PRIMARY KEY AUTOINCREMENT,
        nom_coord CHAR(50),
        prenom_coord CHAR(50),
        mop_coord CHAR(50),
        type_coord CHAR(20),
        email_coord CHAR(100),
        tel_coord CHAR(15)
      );
    ''');

    // Table Professeur
    await db.execute(''' 
      CREATE TABLE Professeur (
        id_prof INTEGER PRIMARY KEY AUTOINCREMENT,
        nom_prof CHAR(50),
        prenom_prof CHAR(50),
        mop_prof CHAR(50),
        type_prof CHAR(20),
        email_prof CHAR(100),
        tel_prof CHAR(15),
        id_mat INTEGER,
        FOREIGN KEY (id_mat) REFERENCES Matiere(id_mat)
      );
    ''');

    // Table Matiere
    await db.execute('''
          CREATE TABLE Matiere (
            id_mat INTEGER PRIMARY KEY AUTOINCREMENT,
            libelle_mat TEXT NOT NULL,
            total_horaire INTEGER NOT NULL,
            id_coord INTEGER NOT NULL,
            FOREIGN KEY (id_coord) REFERENCES Coordinateur_filiere (id_coord) ON DELETE CASCADE
          )
        ''');


    // Table Liberation_Exp
    await db.execute('''
      CREATE TABLE Liberation_Exp (
        id_libexp INTEGER PRIMARY KEY AUTOINCREMENT,
        libelle_e TEXT,
        dateDebut TEXT,
        dateFin TEXT,
        id_prof INTEGER,
        id_res INTEGER,
        FOREIGN KEY (id_res) REFERENCES Reservation(id_res) 
        FOREIGN KEY (id_prof) REFERENCES Professeur(id_prof)
      );
    ''');

    // Table Liberation_Def
    await db.execute('''
      CREATE TABLE Liberation_Def (
        id_libdef INTEGER PRIMARY KEY AUTOINCREMENT,
        libelle_d TEXT,
        DateLib TEXT,
        id_res INTEGER, 
        FOREIGN KEY (id_prof) REFERENCES Professeur(id_prof)
        FOREIGN KEY (id_res) REFERENCES Reservation(id_res) 
      );
    ''');

    // Table Reservation
    await db.execute('''
      CREATE TABLE Reservation (
        id_res INTEGER PRIMARY KEY AUTOINCREMENT,
        dateFin TEXT,
        dateDebut TEXT,
        id_prof INTEGER,
        id_fil INTEGER,
        id_crenau INTEGER,
        FOREIGN KEY (id_prof) REFERENCES Professeur(id_prof),
        FOREIGN KEY (id_fil) REFERENCES Filiere(id_fil),
        FOREIGN KEY (id_crenau) REFERENCES Crenau(id_crenau)
      );
    ''');

    // Table Filiere
    await db.execute('''
      CREATE TABLE Filiere (
        id_fil INTEGER PRIMARY KEY AUTOINCREMENT,
        effectif INTEGER,
        niveau CHAR(10),
        id_coord INTEGER,
        FOREIGN KEY (id_coord) REFERENCES Coordinateur_Filiere(id_coord)
      );
    ''');
    await db.execute('''
      CREATE TABLE Emploie (
        id_emploie INTEGER PRIMARY KEY AUTOINCREMENT,
        des_emploie TEXT,
        id_coord INTEGER,
        FOREIGN KEY (id_coord) REFERENCES Coordinateur_Filiere(id_coord)
      );
    ''');

    // Table Crenau
    await db.execute('''
      CREATE TABLE Crenau (
        id_crenau INTEGER PRIMARY KEY AUTOINCREMENT,
        crenauDes CHAR(100),
        disponibilite_salle BOOLEAN,
        id_salle INTEGER,
        FOREIGN KEY (id_salle) REFERENCES Salle(id_salle)
      );
    ''');

    // Table Salle
    await db.execute('''
      CREATE TABLE Salle (
        id_salle INTEGER PRIMARY KEY,
        nom_salle CHAR NOT NULL,
        localisation_salle CHAR NOT NULL,
        type_salle CHAR NOT NULL,
        capacite_salle INTEGER NOT NULL,
        id_resp INTEGER,
        FOREIGN KEY (id_resp) REFERENCES Responsable_salles(id_resp)
      );
    ''');

  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
