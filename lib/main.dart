import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sqflite/sqflite.dart';

// import from client/:
import 'client/user_provider.dart';
import 'client/database_helper.dart';

// import from screens/
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseHelper dbHelper = DatabaseHelper.instance;
  // Print table records
  await dbHelper.printTableRecords();

  // Delete the database
  // await dbHelper.deleteDatabase();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MakkerApp(),
    ),
  );
}

class MakkerApp extends StatelessWidget {
  const MakkerApp({super.key});

  // Widget root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MakkerTheme',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
