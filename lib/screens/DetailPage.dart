
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/details/details_body.dart';


class DetailPage extends StatelessWidget {
  final GroupsModel group;

  const DetailPage({Key key, this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(context),
      body: DetailsBody(
        group: group,
      ),
      // bottomNavigationBar: Container(
      //   child: AdWidget(
      //     ad: AdmobHelper.getBannerAd()..load(),
      //     key: UniqueKey(),
      //   ),
      //   height: 50,
      // ),
    );
  }

  AppBar detailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(right: kDefaultPadding),
        icon: Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'رجوع',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
