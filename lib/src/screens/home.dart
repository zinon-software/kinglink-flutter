import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/screens/admin/admin_screen.dart';
import 'package:whatsapp_group_links/src/screens/home/home_screen.dart';
import 'package:whatsapp_group_links/src/screens/notification/notification_screen.dart';
import 'package:whatsapp_group_links/src/screens/post/post_screen.dart';
import 'package:whatsapp_group_links/src/screens/profile/profile_screen.dart';
import 'package:whatsapp_group_links/src/screens/search/search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedTab = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  final List<Widget> _children = [
    HomeScreen(),
    Search(),
    if (prefs.getString('user_id') != 1.toString()) PostPage(),
    Notifications(),
    Profile(userID: prefs.getString('user_id')),
    if (prefs.getString('user_id') == 1.toString()) Admin(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_selectedTab],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          margin: EdgeInsets.only(left: 10, right: 10),
          currentIndex: _selectedTab,
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[500],
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Color(0xff73544C),
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.search),
              selectedColor: Color(0xff73544C),
            ),

            /// Add Post
            if (prefs.getString('user_id') != 1.toString())
              DotNavigationBarItem(
                icon: Icon(Icons.add_link_sharp),
                selectedColor: Color(0xff73544C),
              ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.favorite),
              selectedColor: Color(0xff73544C),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Color(0xff73544C),
            ),

            /// Admin
            if (prefs.getString('user_id') == 1.toString())
              DotNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings),
                selectedColor: Color(0xff73544C),
              ),
          ],
        ),
      ),
    );
  }
}
