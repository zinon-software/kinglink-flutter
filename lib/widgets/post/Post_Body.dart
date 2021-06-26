import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key key}) : super(key: key);

  @override
  _PostBodyState createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  GroupsModel groupModel;
  FetchApi fetchApi = FetchApi();
  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  void clearText() {
    nameController.clear();
    linkController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: ' اسم المجموعة',
              ),
              controller: nameController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'الرابط',
              ),
              controller: linkController,
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () async {
                String name = nameController.text;
                String link = linkController.text;

                GroupsModel data = await fetchApi.sendGroup(name, link);
                // Navigator.pop(context);
                clearText;

                setState(() {
                  groupModel = data;
                });
              },
              child: Text('إرسال'),
            ),
          ],
        ),
      ),
    );
  }
}
