import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';

import 'package:http/http.dart' as http;

class PostBody extends StatefulWidget {
  final urlServer;
  final nativeIsAd;
  const PostBody({Key key, this.urlServer, this.nativeIsAd}) : super(key: key);

  @override
  _PostBodyState createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  String _mySelection;
  String _myCategory;

  List dataSelection = []; //edited line
  List dataCategory = []; //edited line

  Future<String> getSectionsData() async {
    var res = await http.get(
        Uri.parse('https://${widget.urlServer}.herokuapp.com/api/Sections'),
        headers: {"Accept": "application/json"});
    var resBody = jsonDecode(utf8.decode(res.bodyBytes));
    setState(() {
      dataSelection = resBody;
    });
    return "Sucess";
  }

  Future<String> getCategoryData() async {
    var res = await http.get(
        Uri.parse('https://${widget.urlServer}.herokuapp.com/api/Category'),
        headers: {"Accept": "application/json"});
    var resBody = jsonDecode(utf8.decode(res.bodyBytes));
    setState(() {
      dataCategory = resBody;
    });
    return "Sucess";
  }

  GroupsModel groupModel;
  FetchApi fetchApi = FetchApi();
  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  final _nativeAdController = NativeAdmobController();

  static bool _testMode = false; // مفعل الاعلانات

  @override
  void initState() {
    super.initState();

    //Ads
    _nativeAdController.reloadAd(forceRefresh: true);

    this.getSectionsData();
    this.getCategoryData();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    linkController.dispose();

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
                adUnitID: () {
                  if (_testMode == true) {
                    return "ca-app-pub-3940256099942544/2247696110";
                  } else if (Platform.isAndroid) {
                    return widget.nativeIsAd;
                  } else if (Platform.isIOS) {
                    return "ca-app-pub-9553130506719526/7695414503";
                  } else {
                    throw new UnsupportedError("Unsupported platform");
                  }
                }(),
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
            Row(
              children: [
                SizedBox(width: 20),
                Text(' أقسام الرابط'),
                SizedBox(width: 10),
                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: DropdownButton(
                    items: dataSelection.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _mySelection = newVal;
                      });
                    },
                    value: _mySelection,
                  ),
                ),
                
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Text(' فئة الرابط'),
                SizedBox(width: 10),
                Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: DropdownButton(
                    items: dataCategory.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _myCategory = newVal;
                      });
                    },
                    value: _myCategory,
                  ),
                ),
              ]
            ),
            SizedBox(height: 10),

            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () async {
                String name = nameController.text;
                String link = linkController.text;
                // String linkSwitch;

                // linkSwitch = link.substring(0, 10);

                // switch(linkSwitch){
                //   case "https//chat": _myCategory = 1.toString();
                // }

                if (name == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('ادخل العنوان بالشكل الصحيح'),
                    ),
                  );
                } else {
                  if (link == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ادخل الرابط بالشكل الصحيح'),
                      ),
                    );
                  } else {
                    if (_myCategory == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('قم ب اختيار فئة الرابط'),
                        ),
                      );
                    } else {
                      if (_mySelection == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('قم ب اختيار قسم الرابط'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                ' تم الارسال بنجاح سيتم النشر بعد المراجعة'),
                          ),
                        );
                        nameController.clear();
                        linkController.clear();

                        GroupsModel data = await fetchApi.sendGroup(
                            widget.urlServer,
                            name,
                            link,
                            _myCategory,
                            _mySelection);

                        setState(() {
                          groupModel = data;
                          _myCategory = null;
                          _mySelection = null;
                        });
                      }
                    }
                  }
                }
              },
              child: Text('إرسال'),
            ),
          ],
        ),
      ),
    );
  }
}
