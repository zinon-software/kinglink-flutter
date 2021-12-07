// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel {
    CommentModel({
        this.id,
        this.message,
        this.createdDt,
        this.sender,
        this.group,
    });

    int id;
    String message;
    DateTime createdDt;
    Sender sender;
    Group group;

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        message: json["message"],
        createdDt: DateTime.parse(json["created_dt"]),
        sender: Sender.fromJson(json["sender"]),
        group: Group.fromJson(json["group"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "created_dt": createdDt.toIso8601String(),
        "sender": sender.toJson(),
        "group": group.toJson(),
    };
}

class Group {
    Group({
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
    int createdBy;
    int category;
    int sections;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        activation: json["activation"],
        createdDt: DateTime.parse(json["created_dt"]),
        views: json["views"],
        createdBy: json["created_by"],
        category: json["category"],
        sections: json["sections"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
        "activation": activation,
        "created_dt": createdDt.toIso8601String(),
        "views": views,
        "created_by": createdBy,
        "category": category,
        "sections": sections,
    };
}

class Sender {
    Sender({
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

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
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
