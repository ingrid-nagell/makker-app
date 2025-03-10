import 'package:flutter/material.dart';

// Clients:
import 'package:makker_app/client/database_service_activities.dart';

// Widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';


class ShopActivity extends StatefulWidget {
  const ShopActivity({super.key});

  @override
  _ShopActivityState createState() => _ShopActivityState();
}

class _ShopActivityState extends State<ShopActivity> {
  final DatabaseServiceActivities _databaseService = DatabaseServiceActivities.instance;
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBarNav(title: 'Finn din neste aktivitet'),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'Forspørsler om makker ❤️💪',
  //             style: Theme.of(context).textTheme.headlineSmall,
  //           ),
  //           Padding(padding: EdgeInsets.all(10.0)),

  //           _activtiesList(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNav(title: 'Finn din neste aktivitet'),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              _buildActivityCard(
                title: 'Søndagstur til Varden',
                date: 'Søndag 09.03.2025. Kl. 10:00.',
                description: 'Fellestur til Varden fra parkeringa. Ta gjerne med termos med varm drikke.',
              ),
              const SizedBox(height: 20),
              _buildActivityCard(
                title: 'Box 2',
                date: '',
                description: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    required String date,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      width: 500,
      height: 200,
      color: const Color.fromARGB(255, 197, 215, 184),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 20),
        ),
        ),
        Align(
        alignment: Alignment.topLeft,
        child: Text(
          date,
          style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
        ),
        ),
        Align(
        alignment: Alignment.center,
        child: Text(
          description,
          style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
        ),
        ),
        Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
            return AlertDialog(
            title: const Text('Påmelding'),
            content: const Text('✔️ Du er nå påmeldt på denne aktiviteten.'),
            actions: <Widget>[
              TextButton(
              child: const Text('OK'),
              onPressed: () {
              Navigator.of(context).pop();
              },
              ),
            ],
            );
            },
          );
          }, child: const Text('Meld interesse 👋'),
        ),
        ),
      ],
      ),
    );
  }
}

      // body: Center(
        // child: FutureBuilder<List<Activity>>(
        //   future: _databaseService.getActivities(),
        //   builder: (BuildContext context, AsyncSnapshot<List<Activity>> snapshot) {
        //     if (!snapshot.hasData) {
        //       print('DATA:');
        //       print(snapshot.hasData);


        //       return Center(child: Text('loading'));
        //     }
        //     return snapshot.data!.isEmpty
        //         ? Center(child: Text('No activities available'))
        //         : Center(child: Text('TBA '));
                // : ListView(
                //     children: snapshot.data!.map((activity) {
                //       return Center(
                //           child: ListTile(
                //           title: Text(activity.category)
                //       ));
                //     }).toList,
                //   );
//           }
//         ),
//       )
//     );
//   }
// }
