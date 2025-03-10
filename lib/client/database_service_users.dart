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

  // Singleton instance of the database:
  static Database? _db;
  static final DatabaseServiceUsers instance = DatabaseServiceUsers._constructor();
  DatabaseServiceUsers._constructor();

  // Getter for the database:
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
        db.execute('''
        CREATE TABLE $_usersTableName (
        $_usersId INTEGER PRIMARY KEY,
        $_usersFirstName TEXT NOT NULL,
        $_usersLastName TEXT NOT NULL,
        $_usersEmail TEXT NOT NULL,
        $_usersPwd TEXT NOT NULL
        )
      ''');
      },
    );
    return database;
  }

  void addUser(String firstname, String lastname, String email, String password,) async {
    final db = await database;
    await db.insert(
      _usersTableName, {
        _usersFirstName: firstname,
        _usersLastName: lastname,
        _usersEmail: email,
        _usersPwd: password,
      },
    );
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final data = await db.query(_usersTableName);
    print(data);
    List<User> users = data.map((e) => User(
      id: e['id'] as int,
      firstname: e['first_name'] as String,
      lastname: e['last_name'] as String,
      email: e['email'] as String,
      password: e['password'] as String,
    )).toList();
    return users;
  }

  Future<bool> isUserInDatabase(String email) async {
    final db = await database;
    final data = await db.query(
      _usersTableName,
      where: '$_usersEmail = ?',
      whereArgs: [email],
    );
    print(data);
    return data.isNotEmpty;
  }

  Future<User> getUser(String email) async {
    final db = await database;
    final data = await db.query(
      _usersTableName,
      where: '$_usersEmail = ?',
      whereArgs: [email],
    );
    return User(
      id: data[0]['id'] as int,
      firstname: data[0]['first_name'] as String,
      lastname: data[0]['last_name'] as String,
      email: data[0]['email'] as String,
      password: data[0]['password'] as String,
    );
  }
}
