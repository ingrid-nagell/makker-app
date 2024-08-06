import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:makker_app/widgets/app_nav_bar.dart';
import 'package:makker_app/client/database_service_users.dart';
import 'package:makker_app/models/users.dart';


class DevPage extends StatefulWidget {
  const DevPage({super.key, required this.title});
  final String title;

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  final DatabaseServiceUsers _databaseService = DatabaseServiceUsers.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNav(title: widget.title),
      body: _usersList(),
    );
  }

  Widget _usersList() {
    return FutureBuilder(
      future: _databaseService.getUser(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            User user = snapshot.data![index];
            print(user.firstname);
            return ListTile(title: Text(user.firstname));
          },
        );
      }
    );
  }

}
