import 'package:flutter/material.dart';

// project packages:
import 'package:makker_app/client/database_service.dart';
import '../widgets/app_nav_bar.dart';


class ShopActivity extends StatefulWidget {
  @override
  _ShopActivityState createState() => _ShopActivityState();
}

class _ShopActivityState extends State<ShopActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNav(title: 'Finn din neste aktivitet'),
      body: Text('Shop Activity Here'),
    );
  }
}
