import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/models/ReportModel.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/details/details_body.dart';

class DetailPage extends StatefulWidget {
  final GroupsModel group;
  final urlServer;
  final bannarIsAd;
  final interstIsAd;
  final nativeIsAd;

  const DetailPage(
      {Key key,
      this.group,
      this.urlServer,
      this.bannarIsAd,
      this.nativeIsAd,
      this.interstIsAd})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ReportModel reportModel;
  FetchApi fetchApi = FetchApi();

  bool _testMode = false; // مفعل الاعلانات

  reportOnPressed(String message, String groupId) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم ارسال البلاغ بنجاح'),
      ),
    );
    Navigator.pop(context, 'Cancel');

    ReportModel data =
        await fetchApi.submitReport(widget.urlServer, message, groupId);

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
        urlServer: widget.urlServer,
        interstIsAd: widget.interstIsAd,
        nativeIsAd: widget.nativeIsAd,
        bannarIsAd: widget.bannarIsAd,
      ),
      bottomNavigationBar: Container(
        child: AdmobBanner(
          adUnitId: () {
            if (_testMode == true) {
              return AdmobBanner.testAdUnitId;
            } else if (Platform.isAndroid) {
              return widget.bannarIsAd;
            } else if (Platform.isIOS) {
              return "ca-app-pub-9553130506719526/3053655439";
            } else {
              throw new UnsupportedError("Unsupported platform");
            }
          }(),
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
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Icon(Icons.report),
                      Text(" اسم المجموعة"),
                      Text(widget.group.name),
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
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
