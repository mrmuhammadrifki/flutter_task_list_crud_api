import 'dart:convert';

import 'package:task_app_crud/data/models/add_task_request_model.dart';
import 'package:task_app_crud/data/models/add_task_response_model.dart';
import 'package:task_app_crud/data/models/task_response_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteDataSource {
  Future<List<TaskResponseModel>> getTasks() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((taskJson) => TaskResponseModel.fromJson(taskJson))
          .toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<AddTaskResponseModel> addTask(AddTaskRequestModel data) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      body: json.encode(data.toJson()), // Encode the body to JSON format
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      return AddTaskResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add tasks');
    }
  }

  Future<bool> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete tasks');
    }
  }

  Future<TaskResponseModel> editTask(int id, TaskResponseModel data) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
      body: json.encode(data.toJson()), // Encode the body to JSON format
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return TaskResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add tasks');
    }
  }
}
