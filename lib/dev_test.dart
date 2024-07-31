// import 'package:sqflite/sqflite.dart';

// void main()  {
//   String path = getDatabasesPath()
//   print(path());
// }


import 'package:sqflite/sqflite.dart';

void main() {
  deleteDatabase('users.db');
}

Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase(path);
