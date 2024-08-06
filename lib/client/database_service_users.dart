import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// from /models:
import 'package:makker_app/models/users.dart';

// https://www.youtube.com/watch?v=pFctmsTDoa0
//17m

class DatabaseServiceUsers {

  final String _usersTableName = 'users';
  final String _usersId = 'id';
  final String _usersFirstName = 'first_name';
  final String _usersLastName = 'last_name';
  final String _usersPwd = 'password';
  final String _usersEmail = 'email';
  // final String _usersGender = 'gender';
  // final String _usersAge = 'age';
  // final String _usersLoaction = 'location';

  String dbQuery() {
    final String activitiesQuery = '''
      CREATE TABLE $_usersTableName(
          $_usersId INTEGER PRIMARY KEY,
          $_usersFirstName TEXT,
          $_usersLastName TEXT,
          $_usersEmail TEXT,
          $_usersPwd TEXT
        )
      ''';
    return activitiesQuery;
  }

  static Database? _db;
  // Only one instance of a database service:
  static final DatabaseServiceUsers instance = DatabaseServiceUsers._constructor();
  DatabaseServiceUsers._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    print("PATH: $databaseDirPath");
    //data/user/0/com.example.makker_app/databases
    final databasePath = join(databaseDirPath, '$_usersTableName.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(dbQuery());
      },
    );
    return database;
  }

  void addUser(String firstname, String lastname, String email, String password) async {
    final db = await database;
    await db.insert(
      'users', {
        _usersFirstName: firstname,
        _usersLastName: lastname,
        _usersEmail: email,
        _usersPwd: password,
      },
    );
  }

  Future<List<User>?> getUser() async {
    final db = await database;
    final data = await db.query(_usersTableName);
    print(data);
    List<User> user = data.map((e) => User(
      id: e['id'] as int,
      firstname: e['firstname'] as String,
      lastname: e['lastname'] as String,
      email: e['email'] as String,
      password: e['password'] as String,
    )).toList();
    return user;
  }

}
