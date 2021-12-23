// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);


// detals
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.isFollowing,
    this.postCount,
    this.follows,
    this.followers,
    this.name,
    this.id,
    this.username,
    this.isAdmin,
    this.bio,
    this.avatar,
  });

  bool isFollowing;
  int postCount;
  int follows;
  int followers;
  String name;
  int id;
  String username;
  bool isAdmin;
  String bio;
  String avatar;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        isFollowing: json["isFollowing"],
        postCount: json["post_count"],
        follows: json["follows"],
        followers: json["followers"],
        name: json["name"],
        id: json["id"],
        username: json["username"],
        isAdmin: json["is_admin"],
        bio: json["bio"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "isFollowing": isFollowing,
        "post_count": postCount,
        "follows": follows,
        "followers": followers,
        "name": name,
        "id": id,
        "username": username,
        "is_admin": isAdmin,
        "bio": bio,
        "avatar": avatar,
      };
}


// all


// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);


List<UsersModel> usersModelFromJson(String str) => List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
    UsersModel({
        this.id,
        this.name,
        this.avatar,
        this.description,
        this.user,
        this.follows,
        this.followers,
    });

    int id;
    String name;
    String avatar;
    String description;
    int user;
    List<int> follows;
    List<int> followers;

    factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        description: json["description"],
        user: json["user"],
        follows: List<int>.from(json["follows"].map((x) => x)),
        followers: List<int>.from(json["followers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "description": description,
        "user": user,
        "follows": List<dynamic>.from(follows.map((x) => x)),
        "followers": List<dynamic>.from(followers.map((x) => x)),
    };
}
