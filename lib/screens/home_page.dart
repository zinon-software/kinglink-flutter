import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/models/SectionsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/screens/FilterHomePage.dart';
import 'package:whatsapp_group_links/screens/Post_Page.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdmobInterstitial interstitialAd;

  SectionsModel sectionsModel;
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
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: homeAppBar(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            sectionsRow(),
            SizedBox(
              height: kDefaultPadding / 3,
            ),
            HomeBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Increment',
        // Within the `FirstRoute` widget
        onPressed: () {
          if (interstitialAd != null) {
            interstitialAd.show();
          }
          Get.to(
            () => PostPage(),
          );
        },
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        'مرحبا بكم في تطبيق قروباتي ',
        style: GoogleFonts.getFont('Almarai'),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ],
    );
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
                  onTap: () {
                    Get.to(
                      () => FilterDataGroup(sectionsId: 1),
                    );
                  },
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
                                    () => FilterDataGroup(
                                        sectionsId: sections[index].id),
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
