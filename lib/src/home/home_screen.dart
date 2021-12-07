import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/profile/profile_screen.dart';
import 'package:whatsapp_group_links/src/utility/widget_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "HOME PAGE"),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          children: <Widget>[
            Profile(title: "Home"),
            Profile(title: "Notification"),
            Profile(title: "Profile"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) =>
            setState(() => _pageController.jumpToPage(index)),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(icon: Icon(Icons.apps), title: Text("Home")),
          BottomNavyBarItem(
              icon: Icon(Icons.circle_notifications),
              title: Text("Notification")),
          BottomNavyBarItem(icon: Icon(Icons.person), title: Text("Profile")),
        ],
      ),
    );
  }
}
