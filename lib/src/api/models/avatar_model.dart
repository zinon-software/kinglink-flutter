// To parse this JSON data, do
//
//     final avatarModel = avatarModelFromJson(jsonString);

import 'dart:convert';

AvatarModel avatarModelFromJson(String str) => AvatarModel.fromJson(json.decode(str));

String avatarModelToJson(AvatarModel data) => json.encode(data.toJson());

class AvatarModel {
    AvatarModel({
        this.id,
        this.avatar,
    });

    int id;
    String avatar;

    factory AvatarModel.fromJson(Map<String, dynamic> json) => AvatarModel(
        id: json["id"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
    };
}
