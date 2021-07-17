import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/models/ReportModel.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/details/details_body.dart';

class DetailPage extends StatefulWidget {
  final GroupsModel group;

  const DetailPage({Key key, this.group}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ReportModel reportModel;
  FetchApi fetchApi = FetchApi();

  reportOnPressed(String message, String groupId) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم ارسال البلاغ بنجاح'),
      ),
    );
    Navigator.pop(context, 'Cancel');

    ReportModel data = await fetchApi.submitReport(message, groupId);

    setState(() {
      reportModel = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(context),
      body: DetailsBody(
        group: widget.group,
      ),
      bottomNavigationBar: Container(
        child: AdmobBanner(
          adUnitId: AdsManager.bannerAdUnitId,
          adSize: AdmobBannerSize.SMART_BANNER(context),
        ),
      ),
    );
  }

  AppBar detailsAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        'رجوع',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(Icons.report),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('تقديم بلاغ'),
                content: Column(
                  children: [
                    Icon(Icons.report),
                    Text(" اسم المجموعة"),
                    Text(widget.group.name),
                    Text("  "),
                    Text("  "),
                    Text("  "),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () async {
                        String message = 'الرابط لا يعمل';
                        String groupId = '${widget.group.id}';
                        reportOnPressed(message, groupId);
                      },
                      child: Text("الرابط لا يعمل"),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () async {
                        String message = 'العنوان وهمي';
                        String groupId = '${widget.group.id}';
                        reportOnPressed(message, groupId);
                      },
                      child: Text("العنوان وهمي"),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () async {
                        String message = 'المجموعة غير اخلاقية';
                        String groupId = '${widget.group.id}';
                        reportOnPressed(message, groupId);
                      },
                      child: Text("المجموعة غير اخلاقية"),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {
                        String message = 'القسم غير صحيح';
                        String groupId = '${widget.group.id}';
                        reportOnPressed(message, groupId);
                      },
                      child: Text("القسم غير صحيح"),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('إلغاء'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
