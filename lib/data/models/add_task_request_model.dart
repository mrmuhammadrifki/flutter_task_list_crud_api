import 'dart:convert';

class AddTaskRequestModel {
  final int userId;
  final String title;
  final bool completed;

  AddTaskRequestModel({
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory AddTaskRequestModel.fromRawJson(String str) =>
      AddTaskRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTaskRequestModel.fromJson(Map<String, dynamic> json) =>
      AddTaskRequestModel(
        userId: json["userId"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "completed": completed,
      };
}
