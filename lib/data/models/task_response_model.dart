import 'dart:convert';

class TaskResponseModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TaskResponseModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TaskResponseModel.fromRawJson(String str) =>
      TaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) =>
      TaskResponseModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
