import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_group_links/models/SectionsModel.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/screens/DetailPage.dart';
import 'package:whatsapp_group_links/screens/Filter_Page.dart';
import 'package:whatsapp_group_links/screens/home_page.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/group_cart.dart';

import 'dart:io';

class HomeBody extends StatefulWidget {
  final urlServer;
  final interstIsAd;
  final nativeIsAd;
  final bannarIsAd;
  const HomeBody(
      {Key key,
      this.urlServer,
      this.nativeIsAd,
      this.interstIsAd,
      this.bannarIsAd})
      : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  AdmobInterstitial interstitialAd;

  GroupsModel groupModel;
  FetchApi fetchApi = FetchApi();

  bool _testMode = false; // مفعل الاعلانات

  @override
  void initState() {
    super.initState();

    //Ads
    interstitialAd = AdmobInterstitial(
      adUnitId: () {
        if (_testMode == true) {
          return AdmobInterstitial.testAdUnitId;
        } else if (Platform.isAndroid) {
          return widget.interstIsAd;
        } else if (Platform.isIOS) {
          return "ca-app-pub-9553130506719526/3516689861";
        } else {
          throw new UnsupportedError("Unsupported platform");
        }
      }(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionsRow(),
        SizedBox(
          height: kDefaultPadding / 3,
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
              ),
              RefreshIndicator(
                onRefresh: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (a, b, c) => HomePage(),
                      transitionDuration: Duration(seconds: 1),
                    ),
                  );
                  return Future.value(false);
                },
                child: FutureBuilder(
                    future: fetchApi.fetchProducts(widget.urlServer, 'Groub'),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<GroupsModel> groups = snapshot.data;
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: groups.length,
                          itemBuilder: (context, index) => GroupCard(
                            itemIndex: index,
                            groups: groups[index],
                            press: () {
                              if (groups[index].activation == true) {
                                selectViews(
                                    groups[index].id,
                                    groups[index].views + 1,
                                    groups[index].name,
                                    groups[index].link);
                                Get.to(
                                  () => DetailPage(
                                    group: groups[index],
                                    urlServer: widget.urlServer,
                                    bannarIsAd: widget.bannarIsAd,
                                    interstIsAd: widget.interstIsAd,
                                    nativeIsAd: widget.nativeIsAd,
                                  ),
                                );
                              } else {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('قيد المراجعة'),
                                    content: Text(
                                        " إن مجموعة  ${groups[index].name} قيد المراجعة"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('فهمت'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  selectViews(int id, int views, String name, String link) async {
    GroupsModel data =
        await fetchApi.updateViews(widget.urlServer, id, views, name, link);

    setState(() {
      groupModel = data;
    });
  }

  sectionsRow() {
    return Container(
      child: FutureBuilder(
          future: fetchApi.fetchSections(widget.urlServer),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // ignore: unused_local_variable
            List<SectionsModel> sections = snapshot.data;
            if (snapshot.data == null) {
              return Container(
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 1.5, // 30 px padding
                      vertical: kDefaultPadding / 5, // 5 px padding
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Text(
                      'جاري التحميل',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              );
            } else {
              return new Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      interstitialAd.show();
                      Get.to(
                        () => FilterPage(
                          sectionsId: '/top',
                          sectionsName: 'الأكثر مشاهدة',
                          urlServer: widget.urlServer,
                          bannarIsAd: widget.bannarIsAd,
                          interstIsAd: widget.interstIsAd,
                          nativeIsAd: widget.nativeIsAd,
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 0.5, // 30 px padding
                        vertical: kDefaultPadding / 5, // 5 px padding
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        'الأكثر مشاهدة',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding / 3,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 30.0,
                      child: new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sections.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Row(
                            children: [
                              SizedBox(
                                width: kDefaultPadding / 3,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    () => FilterPage(
                                      sectionsId:
                                          '?sections=${sections[index].id.toString()}',
                                      sectionsName: sections[index].name,
                                      urlServer: widget.urlServer,
                                      bannarIsAd: widget.bannarIsAd,
                                      interstIsAd: widget.interstIsAd,
                                      nativeIsAd: widget.nativeIsAd,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        kDefaultPadding * 1.5, // 30 px padding
                                    vertical:
                                        kDefaultPadding / 5, // 5 px padding
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Text(
                                    sections[index].name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
