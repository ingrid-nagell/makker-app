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
  final String _activitiesCreatedBy = 'createdBy';
  final String _activitiesDate = 'date';
  final String _activitiesCategory = 'category';
  final String _activitiesLocation = 'location';
  final String _activitiesAdress = 'address';
  final String _activitiesDescription = 'description';
  final String _activitiesActive = 'active';

  String dbQuery() {
    final String activitiesQuery = '''
      CREATE TABLE $_activityTableName(
        $_activitiesId INTEGER PRIMARY KEY,
        $_activitiesCreatedBy TEXT,
        $_activitiesDate TEXT,
        $_activitiesCategory TEXT,
        $_activitiesLocation TEXT,
        $_activitiesAdress TEXT,
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
    // print("PATH: $databaseDirPath");
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
    String date,
    String category,
    String location,
    String address,
    String description,
    bool active,
  ) async {

    final db = await database;
    await db.insert(
      _activityTableName, {
        _activitiesCreatedBy: createdBy,
        _activitiesDate: date,
        _activitiesCategory: category,
        _activitiesLocation: location,
        _activitiesAdress: address,
        _activitiesDescription: description,
        _activitiesActive: active,
      },
    );
  }

  Future<List<Activity>> getActivities() async {
    final db = await database;
    final List<Map<String, Object?>> activities = await db.query(_activityTableName);
    // Convert the list of each activity's fields into a list of `Activity` objects.
    return [
      for (final {
          'id': id as int,
          'created_by': createdBy as String,
          'date': date as String,
          'category': category as String,
          'location': location as String,
          'address': address as String,
          'description': description as String,
          'active': active as bool,
          } in activities)
        Activity(
          id: id,
          createdBy: createdBy,
          date: date,
          category: category,
          location: location,
          address: address,
          description: description,
          active: active,
        ),
    ];
  }
}
