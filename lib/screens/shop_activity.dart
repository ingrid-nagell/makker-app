import 'package:flutter/material.dart';
import 'package:makker_app/client/database_helper.dart';

// Clients:
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
  final activityManager = ActivityManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNav(title: 'Finn din neste aktivitet', isLoggedIn: true),
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
            future: activityManager.getActivities(),
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
                        activityId: activity.activityId,
                        category: activity.activityCategory,
                        title: activity.activityTitle,
                        description: activity.activityDescription,
                        date: activity.activityDate,
                        location: activity.activityLocation,
                        type: activity.activityType,
                        userId: activity.createdBy,
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
    required int activityId,
    required String category,
    required String title,
    required String description,
    required String date,
    required String location,
    required String type,

    required int userId,

  }) {
    final currentUser = Provider.of<UserProvider>(context).user;

    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      constraints: const BoxConstraints(minWidth: 500),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 197, 215, 184),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
        title,
        style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 20),
        ),
        const SizedBox(height: 5),
        Text(
        category,
        style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
        "$location, dato: $date",
        style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
        description,
        style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
        ),
        const SizedBox(height: 10),
        Align(
        alignment: Alignment.bottomRight,
        child: currentUser?.userId == userId ? AuthorWidget(activityId: activityId) : NotAuthorWidget(),
        ),
      ],
      ),
    );
  }
}

class AuthorWidget extends StatelessWidget {
  final activityManager = ActivityManager();
  final int activityId;

  AuthorWidget({super.key, required this.activityId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Du er arrangør.'),
        ),
        TextButton(
            onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Avlys arrangement'),
                content: const Text('Er du sikker på du vil avlyse?'),
                actions: <Widget>[
                TextButton(
                  onPressed: () {
                    activityManager.updateActivity(activityId, "false");
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ja, avlys'),
                ),
                ElevatedButton(
                  child: const Text('Avbryt'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ],
              );
              },
            );
          },
          child: const Text('Avlys arrangement'),
        ),
      ],
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
