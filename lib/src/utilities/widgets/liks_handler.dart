
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/like_services.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';

class LieksHendler extends StatefulWidget {
  const LieksHendler({Key key, this.group}) : super(key: key);
  final GroupModel group;

  @override
  _LieksHendlerState createState() => _LieksHendlerState();
}

class _LieksHendlerState extends State<LieksHendler> {
  bool isLike = false;
  int like_count = 0;

  @override
  void initState() {
    like_count = widget.group.likes.length;
    super.initState();
    setLiek();
  }

  void setLiek() {
    widget.group.likes.map((e) {
      if (e.user.toString() == prefs.getString('user_id').toString()) {
        setState(() {
          isLike = !isLike;
        });
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: (isLike == false)
              ? Icon(Icons.favorite_border)
              : Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
          onPressed: () {
            LikeServices.makeLike(widget.group.id.toString());
            if (isLike == false) {
              setState(() {
                isLike = !isLike;
                like_count += 1;
              });
            } else {
              setState(() {
                isLike = !isLike;
                like_count -= 1;
              });
            }
          },
        ),
        Text(like_count.toString() + ' إعجاب'), // تعديل جديد
      ],
    );
  }
}
