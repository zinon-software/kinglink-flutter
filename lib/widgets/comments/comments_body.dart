import 'package:flutter/material.dart';
import 'package:whatsapp_group_links/models/CommentsModel.dart';
import 'package:whatsapp_group_links/network/fetchApi.dart';

class CommentsBody extends StatefulWidget {
  final groupId;

  const CommentsBody({Key key, this.groupId}) : super(key: key);

  @override
  _CommentsBodyState createState() => _CommentsBodyState();
}

class _CommentsBodyState extends State<CommentsBody> {
  FetchApi fetchApi = FetchApi();
  CommentsModel commentsModel;

  List<String> _comments = ['fhff', 'hdytdty', 'hry6fy'];

  void _addComment(String val) {
    setState(() {
      _comments.add(val);
    });
  }
  void _addCommentApi(String val) async {
    CommentsModel data = await fetchApi.submitComment(val, widget.groupId);
    setState(() {
      commentsModel = data;
    });
  }

  Widget _buildCommentList() {
    return ListView.builder(
      // ignore: missing_return
      itemBuilder: (context, index) {
        if (index < _comments.length) {
          return _buildCommentItem(_comments[index]);
        }
      },
    );
  }

  Widget _buildCommentItem(String comment) {
    return ListTile(
      title: Text(comment),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: _buildCommentList(),
          ),
          TextField(
            onSubmitted: (String submittedStr) {
              _addComment(submittedStr);
              _addCommentApi(submittedStr);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
              hintText: 'اكتب تعليق',
            ),
          )
        ],
      ),
    );
  }
}
