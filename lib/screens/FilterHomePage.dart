import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/home_body.dart';

class FilterDataGroup extends StatefulWidget {
  final sectionsId;
  const FilterDataGroup({Key key, this.sectionsId}) : super(key: key);

  @override
  _FilterDataGroupState createState() => _FilterDataGroupState();
}

class _FilterDataGroupState extends State<FilterDataGroup> {
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
            HomeBody(),
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
        'رجوع',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
