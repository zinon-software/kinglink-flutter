// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:whatsapp_group_links/src/models/group_model.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    ProfileModel({
        this.postCount,
        this.follows,
        this.followers,
        this.name,
        this.username,
        this.bio,
        this.avatar,
        this.groupList,
    });

    int postCount;
    int follows;
    int followers;
    String name;
    String username;
    String bio;
    String avatar;
    List<GroupModel> groupList;

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        postCount: json["post_count"],
        follows: json["follows"],
        followers: json["followers"],
        name: json["name"],
        username: json["username"],
        bio: json["bio"],
        avatar: json["avatar"],
        groupList: List<GroupModel>.from(json["group_list"].map((x) => GroupModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "post_count": postCount,
        "follows": follows,
        "followers": followers,
        "name": name,
        "username": username,
        "bio": bio,
        "avatar": avatar,
        "group_list": List<dynamic>.from(groupList.map((x) => x.toJson())),
    };
}
