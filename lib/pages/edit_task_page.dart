import 'package:flutter/material.dart';
import 'package:task_app_crud/data/datasources/task_remote_data_source.dart';
import 'package:task_app_crud/data/models/task_response_model.dart';
import 'package:task_app_crud/pages/home_page.dart';

class EditTaskPage extends StatefulWidget {
  final TaskResponseModel task;
  const EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final titleController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.task.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
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
              final newModel = TaskResponseModel(
                  title: titleController.text,
                  userId: widget.task.userId,
                  id: widget.task.id,
                  completed: widget.task.completed);
              await TaskRemoteDataSource().editTask(widget.task.id, newModel);
              if (context.mounted) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
              }
            },
            child: const Text('Edit'),
          )
        ],
      ),
    );
  }
}
