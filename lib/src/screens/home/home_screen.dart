import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/services/group_services.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/bubble_stories_handler.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/snapshot_handler.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text(
      //         "لنكاتي",
      //         style: TextStyle(color: Colors.black),
      //       ),
      //       Row(
      //         children: [
      //           Icon(Icons.add),
      //           Padding(
      //             padding: const EdgeInsets.all(24.0),
      //             child: Icon(Icons.favorite),
      //           ),
      //           Icon(Icons.share),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
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
    // final groupProvider = Provider.of<List<GroupModel>>(context);

    return FutureBuilder(
      future: Provider.of<GroupServices>(context).getGroup(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshotHandler(snapshot, context);
      },
    );
    // groupProvider == null
    //     ? Container(
    //         child: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       )
    //     : (groupProvider.length == 0)
    //         ? Container(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 // SvgPicture.asset('assets/images/no_content.svg', height: 260.0),
    //                 Icon(Icons.sync_problem),
    //                 Padding(
    //                   padding: EdgeInsets.only(top: 20.0),
    //                   child: Text(
    //                     "No Posts",
    //                     style: TextStyle(
    //                       color: Colors.redAccent,
    //                       fontSize: 40.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           )
    //         : ListView.builder(
    //             shrinkWrap: true,
    //             physics: const NeverScrollableScrollPhysics(),
    //             itemCount: groupProvider.length,
    //             itemBuilder: (context, index) => GroupCard(
    //                   itemIndex: index,
    //                   group: groupProvider[index],
    //                   press: () {
    //                     print('Card tapped.');
    //                   },
    //                 ));
  }
}
