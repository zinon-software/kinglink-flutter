import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/models/avatar_model.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'package:whatsapp_group_links/src/screens/profile/edit_profile_screen.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key key, this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final avatars = Provider.of<List<AvatarModel>>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditProfile(user: user, avatar: user.avatar),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: avatars == null
          ? Align(child: new CircularProgressIndicator())
          : buildGredView(avatars, context),
    );
  }

  buildGredView(List<AvatarModel> avatars, BuildContext context) {
    List<GridTile> gridTiles = [];
    avatars.forEach((post) {
      gridTiles.add(
        GridTile(
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProfile(user: user, avatar: post.avatar),
                  ),
                );
              },
              child: Image.network(
                (post.avatar),
              ),
            ),
          ),
        ),
      );
    });
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: gridTiles,
    );
  }
}
