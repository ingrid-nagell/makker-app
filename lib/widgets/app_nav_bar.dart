import 'package:flutter/material.dart';

class AppBarNav extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarNav({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber, //Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
