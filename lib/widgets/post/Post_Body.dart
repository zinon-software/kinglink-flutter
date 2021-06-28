import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key key}) : super(key: key);

  @override
  _PostBodyState createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  GroupsModel groupModel;
  FetchApi fetchApi = FetchApi();
  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  final _nativeAdController = NativeAdmobController();

  AdmobInterstitial interstitialAd;

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
    _nativeAdController.reloadAd(forceRefresh: true);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    linkController.dispose();

    interstitialAd.dispose();
    _nativeAdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.width / 3,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20.0),
              child: NativeAdmob(
                adUnitID: AdsManager.nativeAdUnitId,
                numberAds: 3,
                controller: _nativeAdController,
                type: NativeAdmobType.full,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.tealAccent,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  hintText: 'اسم المجموعة',
                  suffixIcon: Icon(Icons.people),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                controller: nameController,
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.tealAccent,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  hintText: 'الرابط',
                  suffixIcon: Icon(Icons.link),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                controller: linkController,
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () async {
                String name = nameController.text;
                String link = linkController.text;

                nameController.clear();
                linkController.clear();

                GroupsModel data = await fetchApi.sendGroup(name, link);

                setState(() {
                  groupModel = data;
                });
              },
              child: Text('إرسال'),
            ),
          ],
        ),
      ),
    );
  }
}
