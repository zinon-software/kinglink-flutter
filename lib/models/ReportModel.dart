// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

List<ReportModel> reportModelFromJson(String str) => List<ReportModel>.from(json.decode(str).map((x) => ReportModel.fromJson(x)));

String reportModelToJson(List<ReportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportModel {
    ReportModel({
        this.id,
        this.message,
        this.createdDt,
        this.group,
    });

    int id;
    String message;
    DateTime createdDt;
    int group;

    factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json["id"],
        message: json["message"],
        createdDt: DateTime.parse(json["created_dt"]),
        group: json["group"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "created_dt": createdDt.toIso8601String(),
        "group": group,
    };
}
