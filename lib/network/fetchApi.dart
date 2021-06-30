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
}
