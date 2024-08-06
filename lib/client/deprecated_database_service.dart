// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// // from /models:
// import 'package:makker_app/models/users.dart';

// https://www.youtube.com/watch?v=pFctmsTDoa0
//17m

// class DatabaseService {
//   Future<Database> getDatabase(databaseName, databaseQuery) async {
//     final databaseDirPath = await getDatabasesPath();
//     print("PATH: $databaseDirPath");
//     //data/user/0/com.example.makker_app/databases
//     final databasePath = join(databaseDirPath, '$databaseName.db');
//     final database = await openDatabase(
//       databasePath,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute(databaseQuery);
//       },
//     );
//     return database;
//   }
// }


// class UserDatabaseClient {

//   final String _users_table_name = 'users';
//   final String _users_db_id = 'id';
//   final String _users_db_first_name = 'first_name';
//   final String _users_db_last_name = 'last_name';
//   final String _users_db_pwd = 'password';
//   final String _users_db_email = 'email';
//   // final String _users_db_gender = 'gender';
//   // final String _users_db_age = 'age';
//   // final String _users_db_loaction = 'location';

//   String dbQuery() {
//     final String activitiesQuery = '''
//       CREATE TABLE $_users_table_name(
//           $_users_db_id INTEGER PRIMARY KEY,
//           $_users_db_first_name TEXT,
//           $_users_db_last_name TEXT,
//           $_users_db_email TEXT,
//           $_users_db_pwd TEXT
//         )
//       ''';
//     return activitiesQuery;
//   }

//   static Database? _db;
//   // Only one instance of a database service:
//   static final UserDatabaseClient instance = UserDatabaseClient._constructor();
//   UserDatabaseClient._constructor();

//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await DatabaseService.getDatabase(_users_table_name, dbQuery());
//     return _db!;
//   }

//   void addUser(String firstname, String lastname, String email, String password) async {
//     final db = await database;
//     await db.insert(
//       'users', {
//         _users_db_first_name: firstname,
//         _users_db_last_name: lastname,
//         _users_db_email: email,
//         _users_db_pwd: password,
//       },
//     );
//   }

//   Future<List<User>?> getUser() async {
//     final db = await database;
//     final data = await db.query(_users_table_name);
//     print(data);
//     List<User> user = data.map((e) => User(
//       id: e['id'] as int,
//       firstname: e['firstname'] as String,
//       lastname: e['lastname'] as String,
//       email: e['email'] as String,
//       password: e['password'] as String,
//     )).toList();
//     return user;
//   }

// }
