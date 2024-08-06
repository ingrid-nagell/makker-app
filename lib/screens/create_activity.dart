import 'package:flutter/material.dart';

// project packages:
import 'package:makker_app/client/database_service.dart';
import '../widgets/app_nav_bar.dart';


class CreateActivity extends StatefulWidget {
  @override
  _CreateActivityState createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNav(title: 'Opprett ny aktivitet'),
      body: Text('Create Activity here'),
    );
  }
}
