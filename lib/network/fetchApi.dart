import 'dart:convert';
import 'dart:async';
import 'package:whatsapp_group_links/models/groupsModel.dart';
import 'package:http/http.dart' as http;

class FetchApi {
  // git request
  Future<List<GroupsModel>> fetchProducts() async {
    http.Response response =
        await http.get(Uri.parse("https://kinglink.herokuapp.com/api/Groub"));

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

  // post request
  Future<GroupsModel> sendGroup(String name, String link) async {
    var response = await http
        .post(Uri.parse('https://kinglink.herokuapp.com/api/Groub'), body: {
      'name': name,
      'link': link,
    });

    if (response.statusCode == 201) {
      String responseString = response.body;
      welcomeFromJson(responseString);
    } else {
      return null;
    }
  }

  // post request
  Future<GroupsModel> updateViews(int id, int views, String name, String link) async {
    final response = await http.put(
      Uri.parse('https://kinglink.herokuapp.com/api/Groub/$id'),
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
}
