import 'package:flutter/material.dart';
import 'package:makker_app/screens/home.dart';
import 'package:makker_app/screens/my_page.dart';

class AppBarNav extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLoggedIn;
  const AppBarNav({super.key, required this.title, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Text(title),
      leading: IconButton(
        icon: Icon(Icons.home),
        onPressed: () {
          if (isLoggedIn) {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyPage()),
        );
          } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        }
      },
      ),
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
