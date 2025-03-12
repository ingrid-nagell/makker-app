import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import from client/:
import 'client/user_provider.dart';

// import from screens/
import 'screens/home.dart';

// import from dev
// import 'dev/delete_db.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
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
      home: const HomePage(title: '👥 Makker'),
    );
  }
}
