// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

List<CommentsModel> commentsModelFromJson(String str) => List<CommentsModel>.from(json.decode(str).map((x) => CommentsModel.fromJson(x)));

String commentsModelToJson(List<CommentsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsModel {
    CommentsModel({
        this.id,
        this.message,
        this.createdDt,
        this.sender,
        this.group,
    });

    int id;
    String message;
    DateTime createdDt;
    int sender;
    int group;

    factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        id: json["id"],
        message: json["message"],
        createdDt: DateTime.parse(json["created_dt"]),
        sender: json["sender"] == null ? null : json["sender"],
        group: json["group"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "created_dt": createdDt.toIso8601String(),
        "sender": sender == null ? null : sender,
        "group": group,
    };
}
