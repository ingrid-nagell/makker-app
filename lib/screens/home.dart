import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import '../widgets/app_nav_bar.dart';
import 'register_user.dart';
import 'login.dart';

var heart  = Emoji('heart', '❤️');

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
          ],
        ),
      ),
    );
  }
}
