import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:whatsapp_group_links/static/constants.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key key,
    this.itemIndex,
    this.groups,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final GroupsModel groups;
  final Function press;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 10, vertical: kDefaultPadding / 4),
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: InkWell(
        onTap: press,
        child: Stack(
          children: [
            Align(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "${groups.name}",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  kDefaultPadding * 1.5, // 30 px padding
                              vertical: kDefaultPadding / 5, // 5 px padding
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              children: [
                                Text("الحالة : "),
                                SizedBox(
                                  height: 10,
                                ),
                                Text((() {
                                  if (groups.activation == true) {
                                    return "موثوق";
                                  } else {
                                    return "معلق";
                                  }
                                })())
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  kDefaultPadding * 1.5, // 30 px padding
                              vertical: kDefaultPadding / 5, // 5 px padding
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Text(groups.category.name),
                          ),
                        ),
                      ],
                    ),
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              ),
              alignment: Alignment.center,
            ),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          color: Colors.black26,
                          size: 18,
                        ),
                        SizedBox(width: 7),
                        Text('${groups.views}'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        SizedBox(width: 7),
                        Text(
                            ' ${groups.createdDt.hour}:${groups.createdDt.second}   ${groups.createdDt.day} / ${groups.createdDt.month} / ${groups.createdDt.year}'),
                      ],
                    ),
                  )
                ],
              ),
              alignment: Alignment.bottomLeft,
            ),
          ],
        ),
      ),
    );
  }
}
