import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'package:whatsapp_group_links/src/api/services/profile_services.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key key,
    this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    displayNameController = TextEditingController(text: widget.user.name);
    bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  void dispose() {
    bioController.dispose();
    displayNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user.avatar);
    final profileUpdateServices = Provider.of<ProfileServices>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        leading: profileUpdateServices.isLoading
            ? Align(child: new CircularProgressIndicator())
            : IconButton(
                icon: Icon(
                  Icons.done,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await profileUpdateServices.putProfile(
                      context: context,
                      name: displayNameController.text,
                      avatar: widget.user.avatar,
                      description: bioController.text);
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
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      buildDisplayNameField(),
                      buildBioField(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "الاسم",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Name",
            // errorText: _displayNameValid ? null : " Name too short",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "الوصف",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: "Update Bio",
            // errorText: _bioValid ? null : "Bio too long",
          ),
        )
      ],
    );
  }
}
