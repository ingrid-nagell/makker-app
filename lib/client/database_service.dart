import 'dart:async';

// import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//https://www.youtube.com/watch?v=pFctmsTDoa0
//17m
void main() {
  final  DatabaseService _databaseService = DatabaseService.instance;
  print(_databaseService);
  // insertUser(fido);
  // var all_users = users();
  // print(all_users);
}

class DatabaseService {

  final String users_db_id = 'id';
  final String users_db_first_name = 'first_name';
  final String users_db_last_name = 'last_name';
  final String users_db_pwd = 'password';
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
    final databasePath = join(databaseDirPath, 'users.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE
            users(
              $users_db_id INTEGER PRIMARY KEY,
              $users_db_first_name TEXT,
              $users_db_last_name INTEGER
            )
          ''');
      },
    );
    return database;
  }

  void addUser(String name,) async {
    final db = await database;
    await db.insert(
      'users', {
        users_db_first_name: name,
        users_db_last_name: 23,
      },
    );
  }

  void getUsers() async {
    final db = await database;
    await db.insert(
      'users', {
        users_db_first_name: 'Hello',
        users_db_last_name: 23,
      },
    );
  }
}

class Userx {
  final int id;
  final String firstName;
  final int age;

  Userx({
    required this.id,
    required this.firstName,
    required this.age,
  });

  // Convert a User into a Map.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'age': age,
    };
  }
  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, age: $age}';
  }
}
