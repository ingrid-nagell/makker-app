// import 'package:sqflite/sqflite.dart';

// void main()  {
//   String path = getDatabasesPath()
//   print(path());
// }


import 'package:sqflite/sqflite.dart';

void main() {
  // deleteDatabase('users.db');
  deleteDatabase('/data/user/0/com.example.makker_app/databases/activities.db');
}

Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase(path);
