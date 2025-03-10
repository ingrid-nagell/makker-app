import 'package:flutter/material.dart';

// Clients:
import 'package:makker_app/client/database_service_activities.dart';

// Widgets:
import 'package:makker_app/widgets/app_nav_bar.dart'; // Ensure this file exists and contains the AppBarNav widget definition

// from /models:
import 'package:makker_app/models/activities.dart';

class ShopActivity extends StatefulWidget {
  const ShopActivity({super.key});

  @override
  _ShopActivityState createState() => _ShopActivityState();
}

class _ShopActivityState extends State<ShopActivity> {
  final DatabaseServiceActivities _databaseService = DatabaseServiceActivities.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNav(title: 'Finn din neste aktivitet'),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: _buildActivityList(),
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return FutureBuilder<List<Activity>>(
      future: _databaseService.getActivities(),
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
              return _buildActivityCard(
                title: activity.category,
                date: activity.date,
                description: activity.description,
              );
            },
          );
        }
      },
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
              },
              child: const Text('Meld interesse 👋'),
            ),
          ),
        ],
      ),
    );
  }
}
