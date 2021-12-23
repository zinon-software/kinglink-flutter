import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/models/notification_model.dart';
import 'package:whatsapp_group_links/src/api/services/notification_services.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<NotificationServices>(context).getNotification(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Text(error.toString());
          } else if (snapshot.hasData) {
            List<NotificationModel> notify = snapshot.data;
            if (notify.length == 0) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SvgPicture.asset('assets/images/no_content.svg', height: 260.0),
                    Icon(Icons.sync_problem),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "No Posts",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
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
                },
              );
            }
          } else {
            return Text('حدث خطاْ');
          }
        },
      ),
    );
  }
}
