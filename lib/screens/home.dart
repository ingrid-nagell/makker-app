import 'package:flutter/material.dart';

// from /modules:
import 'package:makker_app/screens/dev.dart';
import 'package:makker_app/screens/my_activities.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            // Title
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
              'Velkommen til Makker ❤️💪',
              style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            const Padding(padding: EdgeInsets.all(16.0)),

            // Buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LogInForm()),
              );
              },
              child: const Text('Logg inn'),
            ),

            const Padding(padding: EdgeInsets.all(10.0)),

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

            const Padding(padding: EdgeInsets.all(16.0)),

            TextButton(
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
              child: const Text('Om Makker'),
            ),

            const Padding(padding: EdgeInsets.all(16.0)),

            // Picture Carousel
            _buildImageCarousel(),

            // DEV BUTTONS:
            const Padding(padding: EdgeInsets.all(16.0)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DevPage(title: 'dev')),
              );
              },
              child: const Text('DEV PAGE'),
            ),
            TextButton(
              style: TextButton.styleFrom(),
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyActivities()),
              );
              },
              child: const Text('Mine aktiviteter'),
            ),
            TextButton(
              style: TextButton.styleFrom(),
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShopActivity()),
              );
              },
              child: const Text('Finn din neste aktivitet'),
            ),
            TextButton(
              style: TextButton.styleFrom(),
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateActivityForm()),
              );
              },
              child: const Text('Opprett aktivitet (finn makker)'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
              Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Flo_dans_Juvs%C3%B8yla_%C3%A0_Rjukan%2C_Norv%C3%A8ge-rotated.jpg/640px-Flo_dans_Juvs%C3%B8yla_%C3%A0_Rjukan%2C_Norv%C3%A8ge-rotated.jpg', width: 300, height: 300, fit: BoxFit.cover),
              const SizedBox(width: 10),
              Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/2017-08-12_Anthony_Fernando-Road_Cycling-2946_%2836156928430%29.jpg/640px-2017-08-12_Anthony_Fernando-Road_Cycling-2946_%2836156928430%29.jpg', width: 300, height: 300, fit: BoxFit.cover),
              const SizedBox(width: 10),
              Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Ren%C4%81te_Fedotova_LVA.jpg/640px-Ren%C4%81te_Fedotova_LVA.jpg', width: 300, height: 300, fit: BoxFit.cover),
        ],
      )
    );
  }
}
