import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MakkerApp());
}

class MakkerApp extends StatelessWidget {
  const MakkerApp({super.key});

  // Widget root of application.
  @override
  Widget build(BuildContext context) {

    // For dev (deleting DBs)
    // deleteDatabase('/data/user/0/com.example.makker_app/databases/activities.db');
    // deleteDatabase('/data/user/0/com.example.makker_app/databases/users.db');

    return MaterialApp(
      title: 'MakkerTheme',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Finn din makker ❤️👥'),
    );

  }

  // For DEV:
  Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase(path);
}
