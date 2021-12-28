import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/models/avatar_model.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'package:whatsapp_group_links/src/api/services/profile_services.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key key, this.user}) : super(key: key);

  final UserModel user;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  String avatar_url;
  @override
  Widget build(BuildContext context) {
    final avatars = Provider.of<List<AvatarModel>>(context);
    final profileUpdateServices = Provider.of<ProfileServices>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: profileUpdateServices.isLoading
            ? Align(child: new CircularProgressIndicator())
            : IconButton(
                icon: Icon(
                  Icons.done,
                  color: Colors.black,
                ),
                onPressed: () async {
                  print(avatar_url);

                  if (avatar_url != null)
                    await profileUpdateServices.putProfile(
                        context: context,
                        name: widget.user.name,
                        avatar: avatar_url.trim(),
                        description: widget.user.bio);
                  else
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('قم بتحديد الصورة'),
                    ));
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
      body: avatar_url != null
          ? Center(
              child: GridTile(
                child: Card(
                  child: Image.network(
                    (avatar_url),
                  ),
                ),
              ),
            )
          : avatars == null
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
              onTap: () async {
                setState(() {
                  avatar_url = post.avatar;
                });
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
