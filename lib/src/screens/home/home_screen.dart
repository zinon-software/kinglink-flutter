import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/models/group_model.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/card_group_handler.dart';
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
    final groupProvider = Provider.of<List<GroupModel>>(context, listen: false);

    return groupProvider == null ? Container(child: Center(
        child: CircularProgressIndicator(),
      ),) : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: groupProvider.length,
          itemBuilder: (context, index) => GroupCard(
                itemIndex: index,
                group: groupProvider[index],
                press: () {
                  print('Card tapped.');
                },
              )); 
  }
}
