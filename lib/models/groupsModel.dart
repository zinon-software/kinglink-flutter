import 'dart:convert';

List<GroupsModel> welcomeFromJson(String str) => List<GroupsModel>.from(json.decode(str).map((x) => GroupsModel.fromJson(x)));

String welcomeToJson(List<GroupsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupsModel {
    GroupsModel({
        this.id,
        this.name,
        this.link,
        this.activation,
        this.createdDt,
        this.createdBy,
    });

    int id;
    String name;
    String link;
    bool activation;
    DateTime createdDt;
    dynamic createdBy;

    factory GroupsModel.fromJson(Map<String, dynamic> json) => GroupsModel(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        activation: json["activation"],
        createdDt: DateTime.parse(json["created_dt"]),
        createdBy: json["created_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
        "activation": activation,
        "created_dt": createdDt.toIso8601String(),
        "created_by": createdBy,
    };
}
