import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/group_services.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'package:whatsapp_group_links/src/api/profile_services.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/snapshot_handler.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/appBar_handler.dart';

class Profile extends StatelessWidget {
  final String user_ID;
  const Profile({Key key, this.user_ID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "الحساب"),
      body: ListView(
        children: [
          FutureBuilder(
            future: Provider.of<ProfileServices>(context).getUser(user_ID),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data;
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    buildCountColumn("posts", user.postCount),
                                    buildCountColumn("followers", user.follows),
                                    buildCountColumn(
                                        "following", user.followers),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    // buildProfileButton(),
                                    FloatingActionButton.extended(
                                      onPressed: () {
                                        // Add your onPressed code here!
                                      },
                                      label: (prefs.getString('user_id') ==
                                              user.id.toString())
                                          ? Text("تعديل",
                                              style: TextStyle(
                                                  color: Colors.black))
                                          : Text("متابعة",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                      backgroundColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            child: ClipOval(
                              child: Image(
                                height: 50.0,
                                width: 50.0,
                                image: user.avatar == ''
                                    ? NetworkImage(
                                        'https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/5146d1dbf9146c4d12a7249e72065a58.png')
                                    : NetworkImage(user.avatar),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 12.0),
                        child: Text(
                          user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          "@${user.username}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(
                          user.bio,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          FutureBuilder(
            future:
                Provider.of<ProfileServices>(context).getProfileGroups(user_ID),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshotHandler(snapshot);
            },
          ),
        ],
      ),
    );
  }

  // buildProfileHeader() {
  //   return;
  // }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  // buildMyGroupHeader(BuildContext context) {
  //   return ;
  // }
}
