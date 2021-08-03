import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/post/Post_Body.dart';
import 'dart:io';

class PostPage extends StatelessWidget {
  final urlServer;
  final nativeIsAd;
  final bannarIsAd;
  const PostPage({Key key, this.urlServer, this.bannarIsAd, this.nativeIsAd}) : super(key: key);

  static bool _testMode = false;  // مفعل الاعلانات

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(context),
      bottomNavigationBar: Container(
        child: AdmobBanner(
          adUnitId: (){
            if (_testMode == true) {
      return AdmobBanner.testAdUnitId;
    } else if (Platform.isAndroid) {
      return bannarIsAd;
    } else if (Platform.isIOS) {
      return "ca-app-pub-9553130506719526/3053655439";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
          }(),
          adSize: AdmobBannerSize.SMART_BANNER(context),
        ),
      ),
      body: PostBody(urlServer:urlServer, nativeIsAd:nativeIsAd,),
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
      actions: [
        IconButton(
          icon: Icon(Icons.report),
          color: Colors.black,

          onPressed: () {
            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('تعليمات النشر'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
                      Text("بسم الله الرحمن الرحيم"),
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
                      Icon(Icons.report),
                      Text(" قم بتعبئة جميع الحقول "),
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
                      Text(" لن يتم عرض الرابط المنشٌُور الا بعد التاكد من صحته "),
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
                      Text(
                          " لاتقم بتكرار الرابط عند تعقبنا لتكرار يتم حذف جميع الروابط "),
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
                      Text(
                          " احرص علئ ان يحصل الرابط الخاص بك على اعلى نسب المشاهدة "),
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
                      Text(
                          "تاكد بان حقل الرابط لا يحتوي على احرف او كلمات زائدة "),
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
                      Text(
                          "يمكنك نشر جميع حسابتك من مختلف منصات التواصل الاجتماعي مثلاً  Tik Tok   يوتيوب سناب واتساب.... "),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('فهمت'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
      title: Text(
        'رجوع',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
