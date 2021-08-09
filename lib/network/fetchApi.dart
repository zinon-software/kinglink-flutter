import 'dart:convert';
import 'dart:async';
import 'package:whatsapp_group_links/models/CommentsModel.dart';
import 'package:whatsapp_group_links/models/ReportModel.dart';
import 'package:whatsapp_group_links/models/SectionsModel.dart';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:http/http.dart' as http;

class FetchApi {
  // القروبات
  Future<List<GroupsModel>> fetchProducts(String urlServer, String url) async {
    http.Response response =
        await http.get(Uri.parse("https://$urlServer.herokuapp.com/api/$url"));

    if (response.statusCode == 200) {
      var body = jsonDecode(utf8.decode(response.bodyBytes));

      List<GroupsModel> group = [];

      for (var item in body) {
        group.add(GroupsModel.fromJson(item));
      }
      return group;
    }
    return null;
  }

  // نشر رابط
  // ignore: missing_return
  Future<GroupsModel> sendGroup(String urlServer,
      String name, String link, String category, String sections) async {
    var response = await http
        .post(Uri.parse('https://$urlServer.herokuapp.com/api/Groub/post'), body: {
      'name': name,
      'link': link,
      'category': category,
      'sections': sections,
    });

    if (response.statusCode == 201) {
      String responseString = response.body;
      groupsModelFromJson(responseString);
    } else {
      return null;
    }
  }

  // المشاهدات
  Future<GroupsModel> updateViews(String urlServer,
      int id, int views, String name, String link) async {
    final response = await http.put(
      Uri.parse('https://$urlServer.herokuapp.com/api/Groub/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'views': views,
        'name': name,
        'link': link,
      }),
    );

    if (response.statusCode == 200) {
      return GroupsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  // البلاغات
  // ignore: missing_return
  Future<ReportModel> submitReport(String urlServer, String message, String groupId) async {
    var response = await http
        .post(Uri.parse('https://$urlServer.herokuapp.com/api/Report'), body: {
      'message': message,
      'group': groupId,
    });

    if (response.statusCode == 201) {
      String responseString = response.body;
      reportModelFromJson(responseString);
    } else {
      return null;
    }
  }

  // التعليقات
  // post
  // ignore: missing_return
  Future<CommentsModel> submitComment(String urlServer, String message, String groupId) async {
    var response = await http
        .post(Uri.parse('https://$urlServer.herokuapp.com/api/Comment'), body: {
      'message': message,
      'group': groupId,
    });

    if (response.statusCode == 201) {
      String responseString = response.body;
      commentsModelFromJson(responseString);
    } else {
      return null;
    }
  }

  // get
  Future<List<CommentsModel>> getCommentsData(String urlServer, String groupId) async {
    http.Response response =
        await http.get(Uri.parse(
          'https://$urlServer.herokuapp.com/api/Comment?group=$groupId'),
      headers: {"Accept": "application/json"},
    );
     if (response.statusCode == 200) {
      var body = jsonDecode(utf8.decode(response.bodyBytes));

      List<CommentsModel> comments = [];

      for (var item in body) {
        comments.add(CommentsModel.fromJson(item));
      }
      return comments;
    }
    return null;
  }







  // الاقسام
  Future<List<SectionsModel>> fetchSections(String urlServer,) async {
    http.Response response = await http
        .get(Uri.parse("https://$urlServer.herokuapp.com/api/Sections"));

    if (response.statusCode == 200) {
      var body = jsonDecode(utf8.decode(response.bodyBytes));

      List<SectionsModel> group = [];

      for (var item in body) {
        group.add(SectionsModel.fromJson(item));
      }
      return group;
    }
    return null;
  }
}
