

import 'dart:convert';

GroupsModel groupsModelFromJson(String str) => GroupsModel.fromJson(json.decode(str));

String groupsModelToJson(GroupsModel data) => json.encode(data.toJson());

class GroupsModel {
    GroupsModel({
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
    dynamic createdBy;
    Category category;
    Category sections;

    factory GroupsModel.fromJson(Map<String, dynamic> json) => GroupsModel(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        activation: json["activation"],
        createdDt: DateTime.parse(json["created_dt"]),
        views: json["views"],
        createdBy: json["created_by"],
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
        "created_by": createdBy,
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
