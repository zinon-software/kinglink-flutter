import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/models/CommentsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';

class TestMe extends StatefulWidget {
  final groupId;
  final urlServer;

  const TestMe({Key key, @required this.groupId, this.urlServer}) : super(key: key);

  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<TestMe> {
  FetchApi fetchApi = FetchApi();
  CommentsModel commentsModel;

  void _addCommentApi(String val) async {
    CommentsModel data = await fetchApi.submitComment(widget.urlServer, val, widget.groupId);
    setState(() {
      commentsModel = data;
    });
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  Widget commentChild() {
    return FutureBuilder(
        future: fetchApi.getCommentsData(widget.urlServer, widget.groupId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<CommentsModel> comments = snapshot.data;
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        // Display the image in large form.
                        print("تم النقر فوق التعليق");
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: new BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                new BorderRadius.all(Radius.circular(50))),
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage('https://picsum.photos/300/30')),
                      ),
                    ),
                    title: Text(
                      () {
                        if (comments[index].sender == null) {
                          return ' مجهول';
                        } else {
                          return comments[index].sender.toString();
                        }
                      }(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(comments[index].message),
                  ),
                );
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommentBox(
        userImage: "https://picsum.photos/300/30",
        child: commentChild(),
        labelText: 'أكتب تعليقا...',
        withBorder: false,
        errorText: 'لا يمكن أن يكون التعليق فارغًا',
        sendButtonMethod: () {
          if (formKey.currentState.validate()) {
            print(commentController.text);
            _addCommentApi(commentController.text);

            commentController.clear();
            FocusScope.of(context).unfocus();
          } else {
            print("ليس متاحا");
          }
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
      ),
    );
  }
}
