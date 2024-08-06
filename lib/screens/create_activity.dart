import 'package:flutter/material.dart';

// from widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';


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
