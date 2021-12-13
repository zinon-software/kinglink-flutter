// import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/screens/home/home_screen.dart';
// import 'package:whatsapp_group_links/src/screens/profile/profile_screen.dart';
// import 'package:whatsapp_group_links/src/screens/reels/reels_screen.dart';
// import 'package:whatsapp_group_links/src/screens/search/search_screen.dart';

// class Home extends StatefulWidget {
//   const Home({Key key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _currentIndex = 0;

//   void _navigateBottomNavBar(int index) {
//     setState(
//       () => _currentIndex = index,
//     );
//   }

//   final List<Widget> _children = [
//     HomeScreen(),
//     Search(),
//     Reels(),
//     Text("Notification"),
//     Profile(title: "Profile"),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         onTap: _navigateBottomNavBar,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.apps), label: "home"),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
//           BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "reels"),
//           BottomNavigationBarItem(icon: Icon(Icons.shop), label: "shop"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "account"),
//         ],
//       ),
//     );
//   }
// }

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/screens/profile/profile_screen.dart';
import 'package:whatsapp_group_links/src/screens/reels/reels_screen.dart';
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
    Text("Notification"),
    Profile(title: "Profile"),
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
          unselectedItemColor: Colors.grey[300],
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Color(0xff73544C),
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.favorite),
              selectedColor: Color(0xff73544C),
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.search),
              selectedColor: Color(0xff73544C),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Color(0xff73544C),
            ),
          ],
        ),
      ),
    );
  }
}
