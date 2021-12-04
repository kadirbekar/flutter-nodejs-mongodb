import 'dart:convert';

List<TaskList> taskListFromJson(String str) => List<TaskList>.from(json.decode(str).map((x) => TaskList.fromJson(x)));

String taskListToJson(List<TaskList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskList {
    TaskList({
        required this.id,
        required this.name,
        required this.description,
        required this.createdDate,
        required this.v,
    });

    String id;
    String name;
    String description;
    DateTime createdDate;
    int v;

    factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        createdDate: DateTime.parse(json["createdDate"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "createdDate": createdDate.toIso8601String(),
        "__v": v,
    };
}