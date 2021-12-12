import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/screens/home/home_screen.dart';
import 'package:whatsapp_group_links/src/screens/profile/profile_screen.dart';
import 'package:whatsapp_group_links/src/screens/reels/reels_screen.dart';
import 'package:whatsapp_group_links/src/screens/search/search_screen.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void _navigateBottomNavBar(int index) {
    setState(
      () => _currentIndex = index,
    );
  }

  final List<Widget> _children = [
    HomeScreen(),
    Search(),
    Reels(),
    Text("Notification"),
    Profile(title: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _navigateBottomNavBar,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "reels"),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "shop"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "account"),
        ],
      ),
    );
  }
}
