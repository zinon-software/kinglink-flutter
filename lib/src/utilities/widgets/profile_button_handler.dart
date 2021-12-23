import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'package:whatsapp_group_links/src/api/services/profile_services.dart';
import 'package:whatsapp_group_links/src/screens/profile/edit_profile_screen.dart';

class BuildProfileButton extends StatefulWidget {
  final UserModel user;

  const BuildProfileButton({Key key, this.user}) : super(key: key);

  @override
  _BuildProfileButtonState createState() => _BuildProfileButtonState();
}

class _BuildProfileButtonState extends State<BuildProfileButton> {
  bool isFollowing = false;
  @override
  void initState() {
    super.initState();
    isFollowing = widget.user.isFollowing;
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final followingProvider = Provider.of<ProfileServices>(context); 

    bool isProfileOwner =
        widget.user.id.toString() == prefs.getString('user_id');
    if (isProfileOwner) {
      return buildButton(
        followingPro: followingProvider,
        text: "Edit Profile",
        function: editProfile,
        user: widget.user,
      );
    } else if (isFollowing) {
      return buildButton(
        followingPro: followingProvider,
        text: "Unfollow",
        // function: handleUnfollowUser,
        function: () {
          setState(() {
            isFollowing = false;
          });
          // remove follower
          followingProvider.following(widget.user.id.toString());
        },
        user: widget.user,
      );
    } else if (!isFollowing) {
      return buildButton(
        followingPro: followingProvider,
        text: "Follow",
        // function: handleFollowUser,
        function: () {
          setState(() {
            isFollowing = true;
          });
          // remove follower
          followingProvider.following(widget.user.id.toString());
        },
        user: widget.user,
      );
    }
  }

  Container buildButton(
      {String text,
      Function function,
      UserModel user,
      ProfileServices followingPro}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: function,
        child: Container(
          width: 200.0,
          height: 27.0,
          child: followingPro.isLoading
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: isFollowing ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isFollowing ? Colors.white : Colors.blue,
            border: Border.all(
              color: isFollowing ? Colors.grey : Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(
          user: widget.user,
        ),
      ),
    );
  }

  handleUnfollowUser() {
    setState(() {
      isFollowing = false;
    });
    // remove follower
  }

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
  }
}
