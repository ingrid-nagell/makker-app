import 'dart:async';

// import 'package:flutter/widgets.dart';
import 'package:makker_app/models/users.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// https://www.youtube.com/watch?v=pFctmsTDoa0
//17m

class DatabaseService {

  final String _users_table_name = 'users';
  final String users_db_id = 'id';
  final String users_db_first_name = 'first_name';
  final String users_db_last_name = 'last_name';
  final String users_db_pwd = 'password';
  final String users_db_email = 'email';
  final String users_db_gender = 'gender';
  final String users_db_age = 'age';
  final String users_db_loaction = 'location';

  static Database? _db;
  // Only one instance of a database service:
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    print("PATH: $databaseDirPath");
    //data/user/0/com.example.makker_app/databases
    final databasePath = join(databaseDirPath, '$_users_table_name.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE
            $_users_table_name(
              $users_db_id INTEGER PRIMARY KEY,
              $users_db_first_name TEXT,
              $users_db_last_name TEXT,
              $users_db_email TEXT,
              $users_db_pwd TEXT
            )
          ''');
      },
    );
    return database;
  }

  void addUser(String firstname, String lastname, String email, String password) async {
    final db = await database;
    await db.insert(
      'users', {
        users_db_first_name: firstname,
        users_db_last_name: lastname,
        users_db_email: email,
        users_db_pwd: password,
      },
    );
  }

  Future<List<User>?> getUser() async {
    final db = await database;
    final data = await db.query('$_users_table_name');
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
