import 'package:flutter/material.dart';
import 'package:makker_app/client/database_helper.dart';
import 'package:makker_app/client/user_provider.dart';
import 'package:makker_app/screens/home.dart';

// from /models:

// from /screens:
import 'package:makker_app/screens/my_activities.dart';
import 'package:makker_app/screens/shop_activity.dart';
import 'package:makker_app/screens/create_activity.dart';

// from /widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';
import 'package:provider/provider.dart';


class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;

    DatabaseHelper dbHelper = DatabaseHelper.instance;
    // Print table records
    dbHelper.printTableRecords();

    return Scaffold(
      appBar: const AppBarNav(title: "Min side", isLoggedIn: true),
      body: SingleChildScrollView(
      child: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Title
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 25.0, bottom: 25),
              child: Text(
                'Velkommen til Makker,\n${currentUser?.firstName} ❤️💪',
                style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center,
              ),
            ),

          //TODO: add cards showing the next two activities

          TextButton(
          style: TextButton.styleFrom(),
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyActivities()),
            );
          },
            child: const Text('📅 Mine aktiviteter (2)'),
          ),

          TextButton(
            style: TextButton.styleFrom(),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShopActivity()),
            );
            },
            child: const Text('🏀 Finn din neste aktivitet'),
          ),
          TextButton(
          style: TextButton.styleFrom(),
          onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateActivityForm()),
            );
            },
            child: const Text('🕺🕺Finn en makker'),
          ),

          const Padding(padding: EdgeInsets.all(16.0)),

          // Picture Carousel
          _buildImageCarousel(),

          const Padding(padding: EdgeInsets.all(5.0)),

          TextButton(
            style: TextButton.styleFrom(),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text('Logg ut'),
            ),

          // About Makker
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

          const Padding(padding: EdgeInsets.all(10.0)),

          Text(
            'All rights reserved © ${DateTime.now().year} Makker App',
            style: Theme.of(context).textTheme.bodySmall,
            ),

        ],
        ),
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
