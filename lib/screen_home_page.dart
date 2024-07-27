import 'package:flutter/material.dart';

import 'app_nav_bar.dart';
import 'screen_register_user.dart';
import 'screen_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNav(title: widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Velkommen til MakkerApp',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogInForm()),
                );
              },
              child: Text('Logg inn'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterUserForm()),
                );
              },
              // Navigate to second route when tapped.
              child: const Text('Registrer ny bruker'),
            ),
            TextButton(
              child: const Text('Om Makker'),
              style: TextButton.styleFrom(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Om Makker'),
                    content: const Text('Makker er din utvalgte app for å finne din neste klatrepartner. (...)'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      )
                    ]
                  ),
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
