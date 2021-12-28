import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/src/utilities/widgets/post/post_body.dart';

class PostPage extends StatelessWidget {
  const PostPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: PostBody(
          urlServer: 'urlServer',
          nativeIsAd: 'nativeIsAd',
        ),
      ),
    );
  }
}
