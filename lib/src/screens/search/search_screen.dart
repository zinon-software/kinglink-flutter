import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'package:whatsapp_group_links/src/api/services/profile_services.dart';
import 'package:whatsapp_group_links/src/screens/profile/profile_screen.dart';

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: Provider.of<ProfileServices>(context).fatchUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Text(error.toString());
          } else if (snapshot.hasData) {
            List<UsersModel> users = snapshot.data;
            if (snapshot.data.toString() == '[]') {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SvgPicture.asset('assets/images/no_content.svg', height: 260.0),
                    Icon(Icons.sync_problem),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "No Posts",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile(userID: users[index].id.toString()),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: Image(
                              height: 50.0,
                              width: 50.0,
                              image: users[index].avatar == ''
                                  ? NetworkImage(
                                      'https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/5146d1dbf9146c4d12a7249e72065a58.png')
                                  : NetworkImage(users[index].avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(users[index].name),
                            Text(
                                "يتابعة ${users[index].followers.length.toString()}"),
                          ],
                        ),
                        trailing: Icon(Icons.more_vert),
                      ),
                    ),
                  );
                },
              );

              // return ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: users.length,
              //   itemBuilder: (context, index) => Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: InkWell(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) =>
              //                 Profile(userID: users[index].id.toString()),
              //           ),
              //         );
              //       },
              //       child: Row(
              //         children: [
              //           Container(
              //             width: 40,
              //             height: 40,
              //             decoration: BoxDecoration(
              //               color: Colors.grey[300],
              //               shape: BoxShape.circle,
              //             ),
              //             child: ClipOval(
              //               child: Image(
              //                 height: 50.0,
              //                 width: 50.0,
              //                 image: users[index].avatar == null
              //                     ? NetworkImage(
              //                         'https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/5146d1dbf9146c4d12a7249e72065a58.png')
              //                     : NetworkImage(users[index].avatar),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Text(
              //             users[index].name != null
              //                 ? users[index].name
              //                 : 'بدون اسم',
              //             style: TextStyle(fontWeight: FontWeight.bold),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ), // end header
              // );
            }
          } else {
            return Text('حدث خطاْ');
          }
        },
      ),
    );
  }
}












// import 'package:flutter/material.dart';

// class Search extends StatefulWidget {
//   const Search({Key key}) : super(key: key);

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search>
//     with AutomaticKeepAliveClientMixin<Search> {
//   TextEditingController searchController = TextEditingController();
//   // Future<QuerySnapshot> searchResultsFuture;

//   handleSearch(String query) {
//     // Future<QuerySnapshot> users = FirebaseFirestore.instance
//     //     .collection('users')
//     //     .where("name", isGreaterThanOrEqualTo: query)
//     //     .get();
//     setState(() {
//       // searchResultsFuture = users;
//     });
//   }

//   clearSearch() {
//     searchController.clear();
//   }

//   AppBar buildSearchField() {
//     // final logoutProvider = Provider.of<AuthServices>(context);
//     return AppBar(
//       backgroundColor: Colors.white,
//       title: TextFormField(
//         controller: searchController,
//         decoration: InputDecoration(
//           hintText: "Search for a user...",
//           filled: true,
//           prefixIcon: Icon(
//             Icons.account_box,
//             size: 28.0,
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: clearSearch,
//           ),
//         ),
//         onFieldSubmitted: handleSearch,
//       ),
//     );
//   }

//   Container buildNoContent() {
//     final Orientation orientation = MediaQuery.of(context).orientation;
//     return Container(
//       child: Center(
//         child: ListView(
//           shrinkWrap: true,
//           children: <Widget>[
//             // SvgPicture.asset(
//             //   'assets/images/search.svg',
//             //   height: orientation == Orientation.portrait ? 300.0 : 150.0,
//             // ),
//             Text(
//               "Find Users",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontStyle: FontStyle.italic,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 60.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   buildSearchResults() {
//     return FutureBuilder(
//         // future: searchResultsFuture,
//         builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         // return circularProgress();
//       }
//       // List<UserResult> searchResults = [];
//       // snapshot.data.docs.forEach((doc) {
//       //   UserV2 user = UserV2.fromDocument(doc);
//       //   UserResult searchResult = UserResult(user);
//       //   searchResults.add(searchResult);
//       // });
//       return ListView(
//           // children: searchResults,
//           );
//     });
//   }

//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);

//     return Scaffold(
//         backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
//         appBar: buildSearchField(),
//         body: buildNoContent()
//         // searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
//         );
//   }
// }
