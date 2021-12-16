import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';
import 'package:whatsapp_group_links/src/screens/profile/avatar_screen.dart';

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
    bool isProfileOwner =
        widget.user.id.toString() == prefs.getString('user_id');
    if (isProfileOwner) {
      return buildButton(
        text: "Edit Profile",
        function: editProfile,
        user: widget.user,
      );
    } else if (isFollowing) {
      return buildButton(
        text: "Unfollow",
        function: handleUnfollowUser,
        user: widget.user,
      );
    } else if (!isFollowing) {
      return buildButton(
        text: "Follow",
        function: handleFollowUser,
        user: widget.user,
      );
    }
  }

  Container buildButton({String text, Function function, UserModel user}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: function,
        child: Container(
          width: 200.0,
          height: 27.0,
          child: Text(
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
        builder: (context) => Avatar(user: widget.user,),
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
