import 'dart:convert';

class AddTaskResponseModel {
  final int userId;
  final String title;
  final bool completed;
  final int id;

  AddTaskResponseModel({
    required this.userId,
    required this.title,
    required this.completed,
    required this.id,
  });

  factory AddTaskResponseModel.fromRawJson(String str) =>
      AddTaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTaskResponseModel.fromJson(Map<String, dynamic> json) =>
      AddTaskResponseModel(
        userId: json["userId"],
        title: json["title"],
        completed: json["completed"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "completed": completed,
        "id": id,
      };
}
