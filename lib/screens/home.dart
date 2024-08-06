import 'package:flutter/material.dart';

// from /modules:
import 'package:makker_app/screens/dev.dart';
import 'package:makker_app/screens/inbox.dart';
import 'package:makker_app/screens/shop_activity.dart';
import 'package:makker_app/screens/login.dart';
import 'package:makker_app/screens/register_user.dart';
import 'package:makker_app/screens/create_activity.dart';

// from /widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';

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
              'Velkommen til Makker ❤️💪',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
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
            Padding(padding: EdgeInsets.all(16.0)),
            TextButton(
              child: const Text('Om Makker'),
              style: TextButton.styleFrom(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Om Makker'),
                    content: const Text(
                      'Makker hjelper deg å finne din neste turkamerat eller klatrepartner. (...)'
                      ),
                    actions: [
                      TextButton(
                        child: const Text('Kontakt oss'),
                        onPressed: () {
                          // Text('email here');
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Tilbake'),
                      )
                    ]
                  ),
                );
              },
            ),

            // DEV BUTTONS:
            Padding(padding: EdgeInsets.all(16.0)),
            ElevatedButton(
              child: const Text('DEV PAGE'),
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DevPage(title: 'dev')),
                );
              },
            ),
            TextButton(
              child: const Text('Innboks'),
              style: TextButton.styleFrom(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Inbox()),
                );
              },
            ),
            TextButton(
              child: const Text('Se alle aktiviteter'),
              style: TextButton.styleFrom(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopActivity()),
                );
              },
            ),
            TextButton(
              child: const Text('Opprett aktivitet'),
              style: TextButton.styleFrom(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateActivity()),
                );
              },
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(),
            //   onPressed: () {
            //     print("hello");
            //     // deleteDatabase('users.db');
            //   },
            //   // Navigate to second route when tapped.
            //   child: const Text('DELETE USERS'),
            // ),
          ],
        ),
      ),
    );
  }

  // Future<void> deleteDatabase(String path) =>
  //   databaseFactory.deleteDatabase(path);
}
