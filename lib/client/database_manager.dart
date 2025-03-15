// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// // from /models:
// import 'package:makker_app/models/attendees.dart';


// class DatabaseServiceAttendees {
//   final String _attendeesTableName = 'attendees';
//   final String _antendenceId = 'id';
//   final String _activityId = 'activity_id';
//   final String _userId = 'user_id';

//   // Singleton instance of the database:
//   // We want to move this to a hosted db
//   static Database? _db;
//   static final DatabaseServiceAttendees instance = DatabaseServiceAttendees._constructor();
//   DatabaseServiceAttendees._constructor();

//   // Getter for the database:
//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await getDatabase();
//     return _db!;
//   }

//   Future<Database> getDatabase() async {
//     final databaseDirPath = await getDatabasesPath();
//     final databasePath = join(databaseDirPath, '$_attendeesTableName.db');
//     final database = await openDatabase(
//       databasePath,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//         CREATE TABLE $_attendeesTableName (
//           $_activityId INTEGER NOT NULL,
//           $_userId INTEGER NOT NULL,
//           PRIMARY KEY ($_activityId, $_userId),
//           FOREIGN KEY ($_activityId) REFERENCES activities(id),
//           FOREIGN KEY ($_userId) REFERENCES users(id)
//         );
//       ''');
//       },
//     );
//     return database;
//   }

//   void addAttendee(
//     int activityId,
//     int userId,
//   ) async {
//     final db = await database;
//     await db.insert(
//       _attendeesTableName, {
//         _activityId: activityId,
//         _userId: userId,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }


//   Future<List<Attendee>> getAttendees() async {
//     final db = await database;
//     final data = await db.query(_attendeesTableName);
//     print(data);
//     List<Attendee> attendees = data.map((e) => Attendee(
//       id: e['id'] as int,
//       activityId: e['activityId'] as int,
//       userId: e['userId'] as int,
//     )).toList();
//     return attendees;
//   }
// }
