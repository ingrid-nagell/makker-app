import 'package:flutter/material.dart';

// from widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';
import 'package:makker_app/screens/activity_history.dart';

class MyActivities extends StatefulWidget {
  const MyActivities({super.key});

  @override
  _MyActivities createState() => _MyActivities();
}

class _MyActivities extends State<MyActivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNav(title: 'Mine aktiviteter'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildActivityCard(
                title: 'Søndagstur til Varden',
                date: 'Søndag 09.03.2025. Kl. 10:00.',
                description: '✉️ Hvor møtes vi? - Lena',
              ),
              const SizedBox(height: 20),
              _buildActivityCard(
                title: 'Klatreøkt',
                date: 'Mandag 10.03.2025. Kl. 10:00.',
                description: '✉️ Katrine vil være din makker!',
              ),
              const SizedBox(height: 20),
              // Divider, put old activities below
              const Divider(
              color: Color.fromARGB(255, 68, 67, 67),
              thickness: 1,
              ),
              const SizedBox(height: 20),

              const Text(
                'Tidligere aktiviteter:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard({required String title, required String date, required String description}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => ActivityHistory(activityName: title,)),
                );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 209, 219, 223),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Color.fromRGBO(51, 44, 54, 1), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
