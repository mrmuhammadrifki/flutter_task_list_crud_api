import 'package:flutter/material.dart';
import 'package:task_app_crud/data/datasources/task_remote_data_source.dart';
import 'package:task_app_crud/data/models/task_response_model.dart';
import 'package:task_app_crud/pages/add_task_page.dart';
import 'package:task_app_crud/pages/detail_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;

  List<TaskResponseModel> tasks = [];

  Future<void> getTasks() async {
    setState(() {
      isLoaded = true;
    });
    tasks = await TaskRemoteDataSource().getTasks();
    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Task List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 2,
      ),
      body: isLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailTaskPage(
                        task: tasks[index],
                      );
                    }));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(tasks[index].title),
                      trailing: const Icon(Icons.check_circle),
                    ),
                  ),
                );
              },
              itemCount: tasks.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTaskPage();
          }));
          getTasks();
        },
        backgroundColor: Colors.blue[800],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
