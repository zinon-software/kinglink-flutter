// To parse this JSON data, do
//
//     final todos = todosFromJson(jsonString);

import 'dart:convert';

List<Todos> todosFromJson(String str) => List<Todos>.from(json.decode(str).map((x) => Todos.fromJson(x)));

String todosToJson(List<Todos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todos {
    Todos({
        this.task,
        this.completed,
        this.timestamp,
        this.updated,
        this.user,
    });

    String task;
    bool completed;
    DateTime timestamp;
    DateTime updated;
    int user;

    factory Todos.fromJson(Map<String, dynamic> json) => Todos(
        task: json["task"],
        completed: json["completed"],
        timestamp: DateTime.parse(json["timestamp"]),
        updated: DateTime.parse(json["updated"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "task": task,
        "completed": completed,
        "timestamp": timestamp.toIso8601String(),
        "updated": updated.toIso8601String(),
        "user": user,
    };
}
