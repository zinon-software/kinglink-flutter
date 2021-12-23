import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'package:whatsapp_group_links/src/api/services/profile_services.dart';
import 'package:whatsapp_group_links/src/screens/post/post_screen.dart';
import 'package:whatsapp_group_links/src/screens/profile/avatar_screen.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/profile_button_handler.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/snapshot_handler.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/appBar_handler.dart';

class Profile extends StatelessWidget {
  final String userID;
  const Profile({Key key, this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context, "الحساب"),
      body: ListView(
        children: [
          buildProfileHeader(context),
          buildButtonPost(context),
          buildProfileBody(context, userID),
        ],
      ),
    );
  }

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

  //////////////////////////////////////

  buildProfileHeader(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return FutureBuilder(
      future: Provider.of<ProfileServices>(context).getUser(userID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('Loading'),
          );
        }
        UserModel user = snapshot.data;

        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ///////////////////////////////////
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: Ink.image(
                          image: NetworkImage(user.avatar),
                          fit: BoxFit.cover,
                          width: 128,
                          height: 128,
                          child:
                              (user.id.toString() == prefs.getString('user_id'))
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Avatar(),
                                          ),
                                        );
                                      },
                                    )
                                  : InkWell(onTap: () {}),
                        ),
                      ),
                    ),
                    if (user.id.toString() == prefs.getString('user_id'))
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: buildEditIcon(color),
                      ),
                  ],
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              ///////////////////////////////////

              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildCountColumn("posts", user.postCount),
                            buildCountColumn("followers", user.follows),
                            buildCountColumn("following", user.followers),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            BuildProfileButton(
                              user: user,
                            ),
                          ],
                        ),
                      ],
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
                  '@${user.username}',
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
      },
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  buildButtonPost(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 2.0),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostPage(),
            ),
          );
        },
        child: Container(
          width: 200.0,
          height: 27.0,
          child: Text(
            'أضافة منشور جديد',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  buildProfileBody(BuildContext context, String userID) {
    return FutureBuilder(
      future: Provider.of<ProfileServices>(context).getProfileGroups(userID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshotHandler(snapshot, context);
      },
    );
  }
}
