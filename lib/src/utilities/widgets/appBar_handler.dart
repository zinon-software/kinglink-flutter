import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/services/auth_services.dart';

AppBar appBar(BuildContext context, String title) {
  final signOutProvider = Provider.of<AuthServices>(context);
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.transparent,
    elevation: 0,
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
