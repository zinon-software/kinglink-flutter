import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/screens/DetailPage.dart';
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


  @override
  void initState() {
    super.initState();

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
    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                future: fetchApi.fetchProducts(),
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
                              builder: (BuildContext context) => AlertDialog(
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
    );
  }

  selectViews(int id, int views, String name, String link) async {
    GroupsModel data = await fetchApi.updateViews(id, views, name, link);

    setState(() {
      groupModel = data;
    });
  }
}
