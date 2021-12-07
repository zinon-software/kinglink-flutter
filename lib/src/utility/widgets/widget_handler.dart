import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/auth_services.dart';

AppBar appBar(BuildContext context, String title) {
  final signOutProvider = Provider.of<AuthServices>(context);
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () async {
          await signOutProvider.signOut(context);
        },
      ),
    ],
  );
}
