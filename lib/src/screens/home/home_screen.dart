import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/group_services.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/snapshot_handler.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/bubble_stories_handler.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "لنكاتي",
              style: TextStyle(color: Colors.black),
            ),
            Row(
              children: [
                Icon(Icons.add),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.favorite),
                ),
                Icon(Icons.share),
              ],
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                BubbleStories(),
                BubbleStories(),
                BubbleStories(),
                BubbleStories(),
                BubbleStories(),
                BubbleStories(),
              ],
            ),
          ),
          buildMyGroupHeader(context),
        ],
      ),
    );
  }

  buildMyGroupHeader(BuildContext context) {
    final groupProvider = Provider.of<GroupServices>(context);

    return FutureBuilder(
      future: groupProvider.getGroup(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshotHandler(snapshot);
      },
    );
  }
}
