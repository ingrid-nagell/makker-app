import 'dart:async';
import 'dart:io';
import 'package:makker_app/models/activities.dart';
import 'package:makker_app/models/users.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static const _databaseName = "makkerdb.db";
  static final _databaseVersion = 1;

  static final _databasePath = 'C:/Users/G020772/data/$_databaseName';

  static final tableUsers = 'Users';
  static final tableActivities = 'Activities';
  static final tableActivityAttendees = 'ActivityAttendees';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

   _initDatabase() async {
    // Use a local path for the database file
    String path = _databasePath;
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUsers (
        UserID INTEGER PRIMARY KEY AUTOINCREMENT,
        FirstName TEXT NOT NULL,
        LastName TEXT NOT NULL,
        Email TEXT NOT NULL,
        Password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableActivities (
        ActivityID INTEGER PRIMARY KEY AUTOINCREMENT,
        ActivityTitle TEXT NOT NULL,
        ActivityDate TEXT NOT NULL,
        CreatedBy INTEGER,
        ActivityCategory TEXT NOT NULL,
        ActivityType TEXT NOT NULL,
        ActivityLocation TEXT NOT NULL,
        ActivityRendezvous TEXT NOT NULL,
        ActivityDescription TEXT NOT NULL,
        ActivityIsActive TEXT NOT NULL,
        FOREIGN KEY (CreatedBy) REFERENCES $tableUsers (UserID)
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableActivityAttendees (
        ActivityID INTEGER,
        UserID INTEGER,
        isCreatedByUser INTEGER,
        PRIMARY KEY (ActivityID, UserID),
        FOREIGN KEY (ActivityID) REFERENCES $tableActivities (ActivityID),
        FOREIGN KEY (UserID) REFERENCES $tableUsers (UserID)
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableUsers, row);
  }

  Future<bool> isUserInDatabase(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      tableUsers,
      where: 'Email = ?',
      whereArgs: [email]
    );
    return result.isNotEmpty;
  }

  Future<int> insertActivity(Map<String, dynamic> row) async {
    Database db = await instance.database;
    row['ActivityIsActive'] = row['ActivityIsActive'] ?? "true"; // Default to active if not provided
    int activityId = await db.insert(tableActivities, row);
    // Insert into ActivityAttendees
    int userId = row['CreatedBy'];
    int isCreatedByUser = 1; // Assuming 1 for true, 0 for false
    await db.insert(tableActivityAttendees, {
      'ActivityID': activityId,
      'UserID': userId,
      'isCreatedByUser': isCreatedByUser
    });
    print('ActivityAttendees record created with ActivityID: $activityId, UserID: $userId, isCreatedByUser: $isCreatedByUser');
    return activityId;
    // await db.insert(tableActivityAttendees, {
    //   'ActivityID': activityId,
    //   'UserID': userId,
    //   'isCreatedByUser': isCreatedByUser
    // });
    // return activityId;
  }

   Future<void> deleteDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = _databasePath;
    await File(path).delete();
    print('Database deleted: $_databaseName');
    _database = null; // Reset the database instance
  }

  Future<void> printTableRecords() async {
    Database db = await instance.database;

    // Get the database path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = _databasePath;
    print('Database location: $path');

    // Get the list of all tables
    List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table'"
    );

    for (var table in tables) {
      String tableName = table['name'];

      // Skip the sqlite_sequence table which is used for AUTOINCREMENT
      if (tableName == 'sqlite_sequence') continue;

      // Count the number of records in each table
      int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName')
      ) ?? 0;

      print('Table: $tableName, Number of records: $count');
    }
  }
}


class UserManager {
  void createUser(String firstname, String lastname, String email, String password) async {
    Map<String, dynamic> user = {
      'FirstName': firstname,
      'LastName': lastname,
      'Email': email,
      'Password': password
    };
    int userId = await DatabaseHelper.instance.insertUser(user);
    print('User created with ID: $userId');
  }

  Future<bool> isUserInDatabase(String email) async {
    bool exists = await DatabaseHelper.instance.isUserInDatabase(email);
    if (exists) {
      print('User with email $email exists in the database.');
    } else {
      print('User with email $email does not exist in the database.');
    }
    return exists;
  }

  Future<User?> getUser(String email) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> result = await db.query(
      DatabaseHelper.tableUsers,
      where: 'Email = ?',
      whereArgs: [email]
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }
}


class ActivityManager {
  void createActivity(
    String activityTitle,
    String activityDate,
    String activityCategory,
    String activityType,
    String activityLocation,
    String activityRendezvous,
    String activityDescription,
    int createdBy
    ) async {
    Map<String, dynamic> activity = {
      'ActivityTitle': activityTitle,
      'ActivityDate': activityDate,
      'ActivityCategory': activityCategory,
      'ActivityType': activityType,
      'ActivityLocation': activityLocation,
      'ActivityRendezvous': activityRendezvous,
      'ActivityDescription': activityDescription,
      'ActivityIsActive': "true",
      'CreatedBy': createdBy
    };
    int activityId = await DatabaseHelper.instance.insertActivity(activity);
    print('Activity created with ID: $activityId');
  }

  void updateActivity(int activityId, String isActive) async {
    Database db = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      'ActivityId': activityId,
      'ActivityIsActive': isActive
    };
    int count = await db.update(DatabaseHelper.tableActivities, row, where: 'ActivityID = ?', whereArgs: [activityId]);
    List<Map<String, dynamic>> updatedRecord = await db.query(
      DatabaseHelper.tableActivities,
      where: 'ActivityID = ?',
      whereArgs: [activityId]
    );
    print('Updated $count records: $updatedRecord');
  }

  Future<List<Activity>> getActivities({String? isActive}) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> result;
    String today = DateTime.now().toIso8601String().split('T').first;

    if (isActive != null) {
      int isActiveValue = (isActive.toLowerCase() == 'true') ? 1 : 0;
      result = await db.query(
        DatabaseHelper.tableActivities,
        where: 'ActivityIsActive = ? AND ActivityDate >= ?',
        whereArgs: [isActiveValue, today],
        orderBy: 'ActivityDate ASC'
      );
    } else {
      result = await db.query(
        DatabaseHelper.tableActivities,
        where: 'ActivityDate >= ?',
        whereArgs: [today],
        orderBy: 'ActivityDate ASC'
      );
    }
    return result.map((map) => Activity.fromMap(map)).toList();
  }

  Future<List<Activity>> getMyActivities(int userId) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> result = await db.query(
      DatabaseHelper.tableActivities,
      where: 'CreatedBy = ?',
      whereArgs: [userId]
    );
    return result.map((map) => Activity.fromMap(map)).toList();
  }

}
