import 'package:flutter/material.dart';

// project packages:
import 'package:makker_app/client/database_service.dart';
import '../widgets/app_nav_bar.dart';


class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNav(title: 'Dine aktiviteter'),
      body: Text('Inbox'),
    );
  }
}