import 'package:admob_flutter/admob_flutter.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/models/SectionsModel.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/screens/DetailPage.dart';
import 'package:whatsapp_group_links/screens/FilterHomePage.dart';
import 'package:whatsapp_group_links/screens/home_page.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/group_cart.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  AdmobInterstitial interstitialAd;

  GroupsModel groupModel;
  FetchApi fetchApi = FetchApi();

  String urlServer = 'kinglink';

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   final remoteConfig = await RemoteConfig.instance;
    //   final defaults = <String, dynamic>{
    //     'urlServer': 'kinglink',
    //     'banarAds': 'ca-app-pub-9553130506719526/2231417956',
    //   };
    //
    //   setState(() {
    //     urlServer = defaults['urlServer'];
    //     banarAds = defaults['banarAds'];
    //   });
    //
    //   await remoteConfig.fetch(expiration: const Duration(hours: 4));
    //   await remoteConfig.activateFetched();
    //   setState(() {
    //     urlServer = remoteConfig.getString("urlServer");
    //     banarAds = remoteConfig.getString("ads");
    //   });
    // });

    //Ads
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
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
    // AdmobBannerSize bannerSize;
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
                    future: fetchApi.fetchProducts(urlServer, 'Groub'),
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
                                if (interstitialAd != null) {
                                  interstitialAd.show();
                                }
                                selectViews(
                                    groups[index].id,
                                    groups[index].views + 1,
                                    groups[index].name,
                                    groups[index].link);
                                Get.to(
                                  () => DetailPage(group: groups[index]),
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
    GroupsModel data = await fetchApi.updateViews(id, views, name, link);

    setState(() {
      groupModel = data;
    });
  }

  sectionsRow() {
    return Container(
      child: FutureBuilder(
          future: fetchApi.fetchSections(),
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
                      '                    ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            } else {
              return new Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (interstitialAd != null) {
                        interstitialAd.show();
                      }
                      Get.to(
                        () => FilterDataGroup(
                          sectionsId: '/top',
                          sectionsName: 'الأكثر مشاهدة',
                          urlServer: urlServer,
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
                                  if (interstitialAd != null) {
                                    interstitialAd.show();
                                  }
                                  Get.to(
                                    () => FilterDataGroup(
                                      sectionsId:
                                          '?sections=${sections[index].id.toString()}',
                                      sectionsName: sections[index].name,
                                      urlServer: urlServer,
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
