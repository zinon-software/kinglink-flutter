// To parse this JSON data, do
//
//     final sectionsModel = sectionsModelFromJson(jsonString);

import 'dart:convert';

List<SectionsModel> sectionsModelFromJson(String str) => List<SectionsModel>.from(json.decode(str).map((x) => SectionsModel.fromJson(x)));

String sectionsModelToJson(List<SectionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SectionsModel {
    SectionsModel({
        this.id,
        this.name,
    });

    int id;
    String name;

    factory SectionsModel.fromJson(Map<String, dynamic> json) => SectionsModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
