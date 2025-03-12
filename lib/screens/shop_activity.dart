import 'package:flutter/material.dart';

// Clients:
import 'package:makker_app/client/database_service_activities.dart';
import 'package:makker_app/client/user_provider.dart';

// Widgets:
import 'package:makker_app/widgets/app_nav_bar.dart'; // Ensure this file exists and contains the AppBarNav widget definition

// from /models:
import 'package:makker_app/models/activities.dart';
import 'package:provider/provider.dart';

class ShopActivity extends StatefulWidget {
  const ShopActivity({super.key});

  @override
  _ShopActivityState createState() => _ShopActivityState();
}

class _ShopActivityState extends State<ShopActivity> {
  final DatabaseServiceActivities _databaseServiceActivities = DatabaseServiceActivities.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNav(title: 'Finn din neste aktivitet'),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: _buildActivityList(),
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    // final DatabaseServiceActivities _databaseServiceActivities = DatabaseServiceActivities.instance;
    return Column(
      children: [
        _buildActivityFilter(),
        Expanded(
          child: FutureBuilder<List<Activity>>(
            future: _databaseServiceActivities.getActivities(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Ingen aktiviteter funnet.');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final activity = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: _buildActivityCard(
                        category: activity.category,
                        title: activity.title,
                        description: activity.description,
                        date: activity.date,
                        location: activity.location,
                        type: activity.type,
                        userId: activity.userId,
                        deltager: false,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.only(left: 20.0, right: 20.0),
        childrenPadding: const EdgeInsets.all(0),
        backgroundColor: Color.fromARGB(255, 228, 226, 213),
        // collapsedBackgroundColor: Color.fromARGB(255, 228, 226, 213),
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[300]!, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[300]!, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        title: const Text('Filtrer aktiviteter'),
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
                ),
              items: <String>['Kategori 1', 'Kategori 2', 'Kategori 3']
              .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                // Implement filtering logic based on category
              },
            ),

            const SizedBox(height: 10),

            TextField(decoration: const InputDecoration(
                labelText: 'Sted',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Implement filtering logic based on location
              },
            ),

            const SizedBox(height: 10),
            TextField(decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Implement filtering logic based on type
              },
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                // Implement the logic to apply the filters
              },
              child: const Text('Filtrer aktiviteter'),
            ),
            ],),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard({
    required String category,
    required String title,
    required String description,
    required String date,
    required String location,
    required String type,

    required int userId,
    required bool deltager,

  }) {
    final currentUser = Provider.of<UserProvider>(context).user;

    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      width: 500,
      height: 200,
      color: const Color.fromARGB(255, 197, 215, 184),
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 20),
            ),
            Text(
              category,
              style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
            ),
            Text(
              "$location, dato: $date",
              style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
            ),
            Text(
              description,
              style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
            ),
            Align(
              alignment: Alignment.bottomRight,
                child: currentUser?.id == userId ? AuthorWidget() : NotAuthorWidget(),
                // Check for already deltager == true and create a new widget for it
                ),
          ],
        ),
    );
  }
}

class AuthorWidget extends StatelessWidget {
  const AuthorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
    ElevatedButton(
      onPressed: () {},
      child: Text('Du er arrangør.')
    );
  }
}

class NotAuthorWidget extends StatelessWidget {
  NotAuthorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Påmelding'),
              content: const Text('Bekreft påmelding for denne aktiviteten.'),
              // content: const Text('✔️ Du er nå påmeldt på denne aktiviteten.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Meld meg på!'),
                  onPressed: () {
                    // update deltagelse in db
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: const Text('Meld interesse 👋'),
    );
  }
}
