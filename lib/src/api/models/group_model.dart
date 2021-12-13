// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
    GroupModel({
        this.id,
        this.titel,
        this.link,
        this.activation,
        this.createdDt,
        this.views,
        this.createdBy,
        this.category,
        this.sections,
        this.likes,
    });

    int id;
    String titel;
    String link;
    bool activation;
    DateTime createdDt;
    int views;
    CreatedBy createdBy;
    Category category;
    Category sections;
    List<CreatedBy> likes;

    factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"],
        titel: json["titel"],
        link: json["link"],
        activation: json["activation"],
        createdDt: DateTime.parse(json["created_dt"]),
        views: json["views"],
        createdBy: CreatedBy.fromJson(json["created_by"]),
        category: Category.fromJson(json["category"]),
        sections: Category.fromJson(json["sections"]),
        likes: List<CreatedBy>.from(json["likes"].map((x) => CreatedBy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titel": titel,
        "link": link,
        "activation": activation,
        "created_dt": createdDt.toIso8601String(),
        "views": views,
        "created_by": createdBy.toJson(),
        "category": category.toJson(),
        "sections": sections.toJson(),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
    });

    int id;
    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class CreatedBy {
    CreatedBy({
        this.id,
        this.name,
        this.avatar,
        this.description,
        this.user,
        this.follows,
        this.followers,
    });

    int id;
    dynamic name;
    String avatar;
    dynamic description;
    int user;
    List<int> follows;
    List<dynamic> followers;

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        description: json["description"],
        user: json["user"],
        follows: List<int>.from(json["follows"].map((x) => x)),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
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
