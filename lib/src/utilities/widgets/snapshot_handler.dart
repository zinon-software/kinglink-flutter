import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';
import 'package:whatsapp_group_links/src/screens/search/search_screen.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/card_group_handler.dart';

StatelessWidget snapshotHandler(AsyncSnapshot snapshot, BuildContext context) {
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
    List<GroupModel> group = snapshot.data;
    if (snapshot.data.toString() == '[]') {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SvgPicture.asset('assets/images/no_content.svg', height: 260.0),
            Icon(Icons.sync_problem),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Text(
                    "No Posts",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Search(),
                        ),
                      );
                    },
                    child: Container(
                      width: 200.0,
                      height: 27.0,
                      child: Text(
                        'متابعة المستخدمين',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
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
          itemBuilder: (context, index) => GroupCard(
                itemIndex: index,
                group: group[index],
                press: () {
                  print('Card tapped.');
                },
              ));
    }
  } else {
    return Text('حدث خطاْ');
  }
}
