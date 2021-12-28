import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/main.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';
import 'package:whatsapp_group_links/src/api/services/admin_services.dart';
import 'package:whatsapp_group_links/src/screens/profile/profile_screen.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/liks_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class GroupCard extends StatelessWidget {
  const GroupCard({Key key, this.itemIndex, this.group, this.press})
      : super(key: key);

  final int itemIndex;
  final GroupModel group;
  final Function press;

  @override
  Widget build(BuildContext context) {
    final adminServices = Provider.of<AdminServices>(context);
    return adminServices.isLoading && group.id.toString() == adminServices.id
        ? Container(
            height: 50,
            color: Colors.red[300],
            child: Center(child: Text('تم حذف المجموعة')),
          )
        : InkWell(
            onTap: press,
            child: Column(
              children: [
                // start header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile(
                                  userID: group.createdBy.id.toString()),
                            ),
                          );
                        },
                        child: Row(
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
                      ),
                      if (prefs.getString('user_id') ==
                              group.createdBy.id.toString() ||
                          prefs.getString('user_id') == 1.toString())
                        PopupMenuButton(
                          padding: EdgeInsets.all(0),
                          offset: Offset(15, 65),
                          // enabled: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              if (prefs.getString('user_id') == 1.toString())
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.share_outlined,
                                      color: Colors.blueAccent[400],
                                    ),
                                    title: Text('نشر'),
                                  ),
                                  onTap: () {
                                    adminServices
                                        .shareAdminGroup(group.id.toString());
                                  },
                                ),
                              PopupMenuItem(
                                child: ListTile(
                                    leading: Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blueAccent[400],
                                    ),
                                    title: Text('تعديل')),
                                onTap: () => print(1),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                    leading: Icon(
                                      Icons.delete_forever,
                                      color: Colors.blueAccent[400],
                                    ),
                                    title: Text('حذف')),
                                onTap: () => adminServices.deleteGroup(
                                    groupID: group.id.toString()),
                              ),
                            ];
                          },
                        ),
                    ],
                  ),
                ), // end header
                Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 20.0),
                      Text(group.titel),
                      SizedBox(height: 20.0),
                      Center(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: () async {
                            var url = group.link;
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'تعذر الإطلاق  $url';
                            }
                          },
                          child: Text(
                            group.category.name,
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 127, 214, 248),
                            ),
                          ),
                          color: Color.fromARGB(255, 42, 5, 247),
                        ),
                      ),
                      Align(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    color: Colors.black26,
                                    size: 18,
                                  ),
                                  SizedBox(width: 7),
                                  Text('${group.views}'),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Colors.yellow,
                                    size: 18,
                                  ),
                                  SizedBox(width: 7),
                                  Text(timeago.format(group.createdDt,
                                      locale: "ar")),
                                ],
                              ),
                            )
                          ],
                        ),
                        alignment: Alignment.bottomLeft,
                      ),
                    ],
                  ),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
