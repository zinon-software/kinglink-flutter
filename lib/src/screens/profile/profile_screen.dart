import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/profile_services.dart';
import 'package:whatsapp_group_links/src/models/profile_model.dart';

class Profile extends StatelessWidget {
  final String title;
  const Profile({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildProfileHeader(),
          buildMyGroupHeader(context),
        ],
      ),
    );
  }

  buildProfileHeader() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildCountColumn("posts", 40),
                        buildCountColumn("followers", 654),
                        buildCountColumn("following", 45),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // buildProfileButton(),
                      ],
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                child: ClipOval(
                  child: Image(
                    height: 50.0,
                    width: 50.0,
                    // image: user.urlImage == ''
                    //     ? AssetImage('assets/images/user1.png')
                    //     : NetworkImage(user.urlImage),
                    image: NetworkImage(
                        'https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/5146d1dbf9146c4d12a7249e72065a58.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "user.name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              "user.location",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 2.0),
            child: Text(
              "user.bio",
            ),
          ),
        ],
      ),
    );
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  buildMyGroupHeader(BuildContext context) {
    final profileProvider = Provider.of<ProfileServices>(context);

    return FutureBuilder(
      future: profileProvider.getMyGroups(context),
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
          List<Todos> group = snapshot.data;
          if (snapshot.data.toString() == '[]') {
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
              itemCount: group.length,
              itemBuilder: (context, index) => Center(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Text(group[index].task),
                  ),
                ),
              ),
            );
          }
        } else if(snapshot.data.toString() == 'no internet'){
          return Text('لايوجد اتصال ب الانترنت');
        }else {
          return Text('حدث خطاْ');
        }
      },
    );
  }
}
