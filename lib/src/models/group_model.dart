// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

List<GroupModel> groupModelFromJson(String str) => List<GroupModel>.from(json.decode(str).map((x) => GroupModel.fromJson(x)));

String groupModelToJson(List<GroupModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupModel {
    GroupModel({
        this.id,
        this.name,
        this.link,
        this.activation,
        this.createdDt,
        this.views,
        this.createdBy,
        this.category,
        this.sections,
    });

    int id;
    String name;
    String link;
    bool activation;
    DateTime createdDt;
    int views;
    CreatedBy createdBy;
    Category category;
    Category sections;

    factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        activation: json["activation"],
        createdDt: DateTime.parse(json["created_dt"]),
        views: json["views"],
        createdBy: CreatedBy.fromJson(json["created_by"]),
        category: Category.fromJson(json["category"]),
        sections: Category.fromJson(json["sections"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
        "activation": activation,
        "created_dt": createdDt.toIso8601String(),
        "views": views,
        "created_by": createdBy.toJson(),
        "category": category.toJson(),
        "sections": sections.toJson(),
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
        this.password,
        this.email,
        this.username,
        this.dateJoined,
        this.lastLogin,
        this.isAdmin,
        this.isActive,
        this.isStaff,
        this.isSuperuser,
    });

    int id;
    String password;
    String email;
    String username;
    DateTime dateJoined;
    DateTime lastLogin;
    bool isAdmin;
    bool isActive;
    bool isStaff;
    bool isSuperuser;

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        password: json["password"],
        email: json["email"],
        username: json["username"],
        dateJoined: DateTime.parse(json["date_joined"]),
        lastLogin: DateTime.parse(json["last_login"]),
        isAdmin: json["is_admin"],
        isActive: json["is_active"],
        isStaff: json["is_staff"],
        isSuperuser: json["is_superuser"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "email": email,
        "username": username,
        "date_joined": dateJoined.toIso8601String(),
        "last_login": lastLogin.toIso8601String(),
        "is_admin": isAdmin,
        "is_active": isActive,
        "is_staff": isStaff,
        "is_superuser": isSuperuser,
    };
}
