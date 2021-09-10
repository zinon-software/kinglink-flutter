import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';
import 'package:whatsapp_group_links/screens/DetailPage.dart';
import 'package:whatsapp_group_links/static/constants.dart';
import 'package:whatsapp_group_links/widgets/home/group_cart.dart';

class FilterBody extends StatefulWidget {
  final sectionsId;
  final urlServer;
  final bannarIsAd;
  final interstIsAd;
  final nativeIsAd;

  FilterBody({Key key,this.sectionsId,
    this.urlServer,
    this.bannarIsAd,
    this.nativeIsAd,
    this.interstIsAd,}) : super(key: key);

  @override
  _FilterBodyState createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  
  GroupsModel groupModel;
  FetchApi fetchApi = FetchApi();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
        ),
        FutureBuilder(
          future: fetchApi.fetchProducts(
              widget.urlServer, "Groub${widget.sectionsId}"),
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
                itemBuilder: (context, index) {
                  return GroupCard(
                    itemIndex: index,
                    groups: groups[index],
                    press: () {
                      if (groups[index].activation == true) {
                        // if (interstitialAd != null) {
                        //   if (groups[index].id % 2 != 0) {
                        //     interstitialAd.show();
                        //   }
                        // }
                        selectViews(groups[index].id, groups[index].views + 1,
                            groups[index].name, groups[index].link);
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
                  );
                },
              );
            }
          },
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
}
