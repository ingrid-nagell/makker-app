import 'dart:async';

import 'package:flutter/material.dart';
import 'package:makker_app/client/database_helper.dart';
import 'package:makker_app/client/user_provider.dart';
import 'package:makker_app/models/activities.dart';
import 'package:makker_app/models/users.dart';

// from widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';
import 'package:makker_app/screens/activity_history.dart';
import 'package:provider/provider.dart';

class MyActivities extends StatefulWidget {
  const MyActivities({super.key});

  @override
  _MyActivities createState() => _MyActivities();
}

class _MyActivities extends State<MyActivities> {
  final activityManager = ActivityManager();
  // late Future<List<Activity>> myActivities;
  late final User? currentUser;
  int _userId = 0;

  @override
  void initState() {
    super.initState();

    currentUser = Provider.of<UserProvider>(context, listen: false).user;

    setState(() {
      _userId = currentUser?.userId ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("USERID: $_userId");
    return Scaffold(
      appBar: const AppBarNav(title: 'Mine aktiviteter', isLoggedIn: true),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              const Text(
                'Mine aktiviteter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildMyActivitiesList(activityManager.getMyActivities(_userId)),
              const Divider(
                color: Color.fromARGB(255, 170, 52, 52),
                height: 20,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ActivityHistory(activityName: 'Tidligere aktiviteter')),
                );
              },
              child: const Text(
                'Tidligere aktiviteter',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 14, 59, 95),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyActivitiesList(function) {
    return Expanded(
      child: FutureBuilder<List<Activity>>(
        future: function,
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
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => ActivityHistory(activityName: title,)),
                );
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        constraints: const BoxConstraints(minWidth: 500),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 209, 219, 223),
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
