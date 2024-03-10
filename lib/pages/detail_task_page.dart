import 'package:flutter/material.dart';
import 'package:task_app_crud/data/datasources/task_remote_data_source.dart';
import 'package:task_app_crud/data/models/task_response_model.dart';
import 'package:task_app_crud/pages/edit_task_page.dart';
import 'package:task_app_crud/pages/home_page.dart';

class DetailTaskPage extends StatefulWidget {
  final TaskResponseModel task;

  const DetailTaskPage({super.key, required this.task});

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Task',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text(widget.task.title),
          const SizedBox(height: 16.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditTaskPage(task: widget.task);
                }));
              },
              child: const Text('Edit'),
            ),
            const SizedBox(
              width: 16.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  backgroundColor: Colors.red[800],
                  foregroundColor: Colors.white),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi'),
                        content: const Text(
                            'Apakah kamu yakin ingin menghapus task ini?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await TaskRemoteDataSource()
                                  .deleteTask(widget.task.userId);
                              if (context.mounted) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomePage();
                                }));
                              }
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
              child: const Text('Delete'),
            ),
          ]),
        ],
      ),
    );
  }
}
