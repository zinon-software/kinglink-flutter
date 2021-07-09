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
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 135.0,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 25,
                      color: Colors.black12),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: SizedBox(
                height: 136.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        groups.id.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        '  اسم القروب || ${groups.name}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5, // 30 px padding
                          vertical: kDefaultPadding / 5, // 5 px padding
                        ),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
