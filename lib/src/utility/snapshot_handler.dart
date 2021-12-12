import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/models/group_model.dart';
import 'package:whatsapp_group_links/src/utility/widgets/card_group_handler.dart';

StatelessWidget snapshotHandler(AsyncSnapshot snapshot) {
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
