import 'package:flutter/material.dart';

// from widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';

class ActivityHistory extends StatefulWidget {
  final String activityName;

  const ActivityHistory({super.key, required this.activityName});

  @override
  _ActivityHistoryState createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // Use the arguments as needed, for example:
    // final activityName = args['activityName'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNav(title: widget.activityName, isLoggedIn: true),
    );
  }
}
