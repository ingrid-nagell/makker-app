import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// from /models:
import 'package:makker_app/models/activities.dart';

// https://www.youtube.com/watch?v=pFctmsTDoa0
//17m

class DatabaseServiceActivities {
  final String _activityTableName = 'activities';

  final String _activitiesId = 'id';
  final String _activitiesCreatedBy = 'created_by';
  final String _activitiesCategory = 'category';
  final String _activitiesName = 'name';
  final String _activitiesLocation = 'loaction';
  final String _activitiesDate = 'date';
  final String _activitiesDescription = 'description';
  final String _activitiesActive = 'active';

  String dbQuery() {
    final String activitiesQuery = '''
      CREATE TABLE $_activityTableName(
        $_activitiesId INTEGER PRIMARY KEY,
        $_activitiesCreatedBy TEXT,
        $_activitiesCategory TEXT,
        $_activitiesName TEXT,
        $_activitiesLocation TEXT,
        $_activitiesDate TEXT,
        $_activitiesDescription TEXT,
        $_activitiesActive BOOLEAN
      )
    ''';
    return activitiesQuery;
  }

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
    print("PATH: $databaseDirPath");
    //data/user/0/com.example.makker_app/databases
    final databasePath = join(databaseDirPath, '$_activityTableName.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(dbQuery());
      },
    );
    return database;
  }

  void addActivity(
    String createdBy,
    String category,
    String name,
    String location,
    String description,
    String date,
    bool active,
  ) async {

    final db = await database;
    await db.insert(
      'activities', {
        _activitiesCreatedBy: createdBy,
        _activitiesCategory: category,
        _activitiesName: name,
        _activitiesLocation: location,
        _activitiesDescription: description,
        _activitiesDate: date,
        _activitiesActive: active,
      },
    );
  }

  Future<List<Activity>?> getActivity() async {
    final db = await database;
    final data = await db.query(_activityTableName);
    print(data);
    List<Activity> activity = data.map((e) => Activity(
      id: e['id'] as int,
      createdBy: e['created_by'] as String,
      category: e['category'] as String,
      name: e['name'] as String,
      location: e['loaction'] as String,
      description: e['description'] as String,
      date: e['date'] as String,
      active: e['active'] as bool,
    )).toList();
    return activity;
  }

}
