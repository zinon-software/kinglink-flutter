import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/api/models/user_model.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key, this.user, this.avatar}) : super(key: key);

  final String avatar;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    print(user.avatar);
    return Container();
  }
}
