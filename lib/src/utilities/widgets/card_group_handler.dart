// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/like_services.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({Key key, this.itemIndex, this.group, this.press})
      : super(key: key);

  final int itemIndex;
  final GroupModel group;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image(
                          height: 50.0,
                          width: 50.0,
                          image: group.createdBy.avatar == null
                              ? NetworkImage(
                                  'https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/5146d1dbf9146c4d12a7249e72065a58.png')
                              : NetworkImage(group.createdBy.avatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      group.createdBy.name != null
                          ? group.createdBy.name
                          : 'بدون اسم',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.menu),
              ],
            ),
          ),
          Container(
            height: 200,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    LieksHendler(group: group),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.chat_bubble_outline),
                    ),
                    Icon(Icons.share),
                  ],
                ),
                Icon(Icons.bookmark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
