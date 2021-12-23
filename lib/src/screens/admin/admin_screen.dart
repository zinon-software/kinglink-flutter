import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/services/admin_services.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/snapshot_handler.dart';

class Admin extends StatelessWidget {
  const Admin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        FutureBuilder(
          future: Provider.of<AdminServices>(context).fatchAdinGroups(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshotHandler(snapshot, context);
          },
        ),
      ]),
    );
  }
}
