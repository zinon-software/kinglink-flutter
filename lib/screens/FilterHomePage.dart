import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/filter_home_body.dart';

class FilterDataGroup extends StatelessWidget {
  final sectionsId;
  final sectionsName;
  final urlServer;

  const FilterDataGroup({Key key, this.sectionsId, this.sectionsName, this.urlServer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              height: kDefaultPadding / 3,
            ),
            FilterHomeBody(
              sectionsId: sectionsId,
              urlServer: urlServer,
            ),
          ],
        ),
      ),
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
        sectionsName,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
