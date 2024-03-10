import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_app_crud/data/datasources/task_remote_data_source.dart';
import 'package:task_app_crud/data/models/add_task_request_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 40),
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white),
            onPressed: () async {
              Random random = Random();
              int uniqueId = random.nextInt(100000) + 1;
              final model = AddTaskRequestModel(
                  userId: uniqueId,
                  title: titleController.text,
                  completed: false);
              await TaskRemoteDataSource().addTask(model);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
