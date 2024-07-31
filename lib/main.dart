import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'screens/home.dart';

void main() {
  runApp(const MakkerApp());
}

class MakkerApp extends StatelessWidget {
  const MakkerApp({super.key});

  // Widget root of application.
  @override
  Widget build(BuildContext context) {

    // For dev (deleting DBs)
    // deleteDatabase('users.db');

    return MaterialApp(
      title: 'MakkerTheme',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Makker\nFinn din klatrepartner'),
    );
  }

  // For DEV:
  Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase(path);
}
