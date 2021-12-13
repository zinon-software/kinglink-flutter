import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/liks_handler.dart';

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
