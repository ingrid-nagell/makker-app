import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// from /models:
import 'package:makker_app/models/activities.dart';

// https://www.youtube.com/watch?v=pFctmsTDoa0
//17m

class DatabaseServiceActivities {
  final String _activityTableName = 'activities_table';

  final String _activitiesId = 'id';
  final String _activitiesUserId = 'userId';
  final String _activitiesDate = 'date';
  final String _activitiesCategory = 'category';
  final String _activitiesLocation = 'location';
  final String _activitiesAdress = 'address';
  final String _activitiesDescription = 'description';

  static Database? _db;

  // Only one instance of a database service:
  static final DatabaseServiceActivities instance = DatabaseServiceActivities._constructor();
  DatabaseServiceActivities._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    // print("PATH: $databaseDirPath");
    //data/user/0/com.example.makker_app/databases
    final databasePath = join(databaseDirPath, '$_activityTableName.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_activityTableName(
            $_activitiesId INTEGER PRIMARY KEY,
            $_activitiesUserId INTEGER NOT NULL,
            $_activitiesDate TEXT,
            $_activitiesCategory TEXT,
            $_activitiesLocation TEXT,
            $_activitiesAdress TEXT,
            $_activitiesDescription TEXT
        )
        ''');
      },
    );
    return database;
  }

  void addActivity(
    int userId,
    String date,
    String category,
    String location,
    String address,
    String description,
  ) async {
    final db = await database;
    await db.insert(
      _activityTableName, {
        _activitiesUserId: userId,
        _activitiesDate: date,
        _activitiesCategory: category,
        _activitiesLocation: location,
        _activitiesAdress: address,
        _activitiesDescription: description,
      },
    );
  }

  Future<List<Activity>> getActivities() async {
    final db = await database;
    final data = await db.query(_activityTableName);
    print(data);

    List<Activity> activities = data.map((e) => Activity(
      id: e['id'] as int,
      userId: e['userId'] as String,
      date: e['date'] as String,
      category: e['category'] as String,
      location: e['location'] as String,
      address: e['address'] as String,
      description: e['description'] as String,
      // active: e['active'] as bool,
      )).toList();
    return activities;
  }
}
