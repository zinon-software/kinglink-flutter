import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/models/notification_model.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notify = Provider.of<List<NotificationModel>>(context);
    return Scaffold(
      body: notify == null
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notify.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: Image(
                              height: 50.0,
                              width: 50.0,
                              image: notify[index].receiver.avatar == ''
                                  ? NetworkImage(
                                      'https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/5146d1dbf9146c4d12a7249e72065a58.png')
                                  : NetworkImage(notify[index].receiver.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(notify[index].action),
                        trailing: Icon(Icons.more_vert),
                      ),
                    );
                  })
            ]),
    );
  }
}
