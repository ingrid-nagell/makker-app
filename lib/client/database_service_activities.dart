// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// // from /models:
// import 'package:makker_app/models/activities.dart';

// // https://www.youtube.com/watch?v=pFctmsTDoa0
// //17m

// class DatabaseServiceActivities {
//   final String _activityTableName = 'activities';

//   final String _activitiesId = 'id';
//   final String _activitiesUserId = 'userId';
//   final String _activitiesDate = 'date';
//   final String _activitiesCategory = 'category';
//   final String _activitiesType = 'type';
//   final String _activitiesLocation = 'location';
//   final String _activitiesRendezvous = 'rendezvous';
//   final String _activitiesTitle = 'title';
//   final String _activitiesDescription = 'description';
//   final String _activitiesIsActive = 'isActive';

//   static Database? _db;

//   // Only one instance of a database service:
//   static final DatabaseServiceActivities instance = DatabaseServiceActivities._constructor();
//   DatabaseServiceActivities._constructor();

//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await getDatabase();
//     return _db!;
//   }

//   Future<Database> getDatabase() async {
//     final databaseDirPath = await getDatabasesPath();
//     print("PATH: $databaseDirPath");
//     //data/user/0/com.example.makker_app/databases
//     final databasePath = join(databaseDirPath, '$_activityTableName.db');
//     print("PATH: $databasePath");

//     final database = await openDatabase(
//       databasePath,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE $_activityTableName(
//             $_activitiesId INTEGER PRIMARY KEY,
//             $_activitiesUserId INTEGER NOT NULL,
//             $_activitiesDate TEXT,
//             $_activitiesCategory TEXT,
//             $_activitiesType TEXT,
//             $_activitiesLocation TEXT,
//             $_activitiesRendezvous TEXT,
//             $_activitiesTitle TEXT,
//             $_activitiesDescription TEXT,
//             $_activitiesIsActive TEXT
//         )
//         ''');
//       },
//     );
//     return database;
//   }

//   void addActivity(
//     int userId,
//     String date,
//     String category,
//     String type,
//     String location,
//     String rendezvous,
//     String title,
//     String description,
//   ) async {
//     final db = await database;
//     await db.insert(
//       _activityTableName, {
//         _activitiesUserId: userId,
//         _activitiesDate: date,
//         _activitiesCategory: category,
//         _activitiesType: type,
//         _activitiesLocation: location,
//         _activitiesRendezvous: rendezvous,
//         _activitiesTitle: title,
//         _activitiesDescription: description,
//         _activitiesIsActive: 'true',
//       },
//     );
//   }

//   Future<List<Activity>> getActivities() async {
//     final db = await database;
//     final data = await db.query(
//       _activityTableName,
//       where: '$_activitiesIsActive = ?',
//       whereArgs: ['true'],
//       orderBy: '$_activitiesDate ASC',
//     );
//     print(data);

//     List<Activity> activities = data.map((e) => Activity(
//       id:       e['id'] as int,
//       userId:   e['userId'] as int,
//       date:     e['date'] as String,
//       category: e['category'] as String,
//       type:     e['type'] as String,
//       location: e['location'] as String,
//       rendezvous: e['rendezvous'] as String,
//       title:    e['title'] as String,
//       description: e['description'] as String,
//       isActive: e['isActive'] as String,
//       )).toList();
//     return activities;
//   }

//   Future<List<String>> getUniqueActivityCategories() async {
//     final db = await database;
//     final data = await db.rawQuery('''
//       SELECT DISTINCT $_activitiesCategory
//       FROM $_activityTableName
//       WHERE $_activitiesIsActive = 'true'
//       ORDER BY $_activitiesCategory ASC
//     ''');
//     List<String> categories = data.map((e) => e[_activitiesCategory] as String).toList();
//     return categories;
//   }

//   Future<List<String>> getQueryActivities(String query) async {
//     final db = await database;
//     final data = await db.rawQuery(query);
//     List<String> types = data.map((e) => e[_activitiesType] as String).toList();
//     return types;
//   }

//   Future<List<Activity>> getMyActivities(int userId) async {
//     final db = await database;
//     final data = await db.query(
//       _activityTableName,
//       where: '$_activitiesUserId = ?',
//       whereArgs: [userId],
//       orderBy: '$_activitiesDate DESC',
//     );
//     print(data);

//     List<Activity> activities = data.map((e) => Activity(
//       id:       e['id'] as int,
//       userId:   e['userId'] as int,
//       date:     e['date'] as String,
//       category: e['category'] as String,
//       type:     e['type'] as String,
//       location: e['location'] as String,
//       rendezvous: e['rendezvous'] as String,
//       title:    e['title'] as String,
//       description: e['description'] as String,
//       isActive: e['isActive'] as String,
//       )).toList();
//     return activities;
//   }

//   Future<void> updateActivity(int id, String isActive) async {
//     final db = await database;
//     await db.update(
//       _activityTableName,
//       {_activitiesIsActive: isActive},
//       where: '$_activitiesId = ?',
//       whereArgs: [id],
//     );
//   }
// }
