// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.postCount,
        this.follows,
        this.followers,
        this.name,
        this.id,
        this.username,
        this.bio,
        this.avatar,
    });

    int postCount;
    int follows;
    int followers;
    String name;
    int id;
    String username;
    String bio;
    String avatar;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        postCount: json["post_count"],
        follows: json["follows"],
        followers: json["followers"],
        name: json["name"],
        id: json["id"],
        username: json["username"],
        bio: json["bio"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "post_count": postCount,
        "follows": follows,
        "followers": followers,
        "name": name,
        "id": id,
        "username": username,
        "bio": bio,
        "avatar": avatar,
    };
}
