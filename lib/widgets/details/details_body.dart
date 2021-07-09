import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_group_links/Ads_state/adsManager.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/details/color_dot.dart';

class DetailsBody extends StatelessWidget {
  final GroupsModel group;

  const DetailsBody({Key key, this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // to provide us the height and the width of the sceen
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorDot(
                      fillColor: kTextLightColor,
                      isSelected: true,
                    ),
                    ColorDot(
                      fillColor: Colors.blue,
                      isSelected: false,
                    ),
                    ColorDot(
                      fillColor: Colors.red,
                      isSelected: false,
                    ),
                  ],
                ),
              ),
              AdsClass(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        '   مجموعة:   ${group.name}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        '   الناشر:   ${group.createdBy}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Center(
                child: RaisedButton(
                  onPressed: () async {
                    var url = group.link;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'تعذر الإطلاق  $url';
                    }
                  },
                  child: Text(
                    "الواتساب   \u{2714}",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 1.5,
            vertical: kDefaultPadding / 2,
          ),
          child: Text(
            ' الساعة :  ${group.createdDt.hour}   ||  التاريخ :  ${group.createdDt.day} / ${group.createdDt.month} / ${group.createdDt.year}',
            style: TextStyle(color: Colors.white, fontSize: 19.0),
          ),
        ),
      ],
    );
  }
}

class AdsClass extends StatefulWidget {
  const AdsClass({Key key}) : super(key: key);

  @override
  _AdsClassState createState() => _AdsClassState();
}

class _AdsClassState extends State<AdsClass> {
  final _nativeAdController = NativeAdmobController();

  @override
  void initState() {
    super.initState();

    //Ads

    _nativeAdController.reloadAd(forceRefresh: true);
  }

  @override
  void dispose() {
    _nativeAdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
