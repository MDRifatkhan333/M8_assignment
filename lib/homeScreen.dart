import 'package:flutter/material.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  List<TASK> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask();
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                tasks[index].taskName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                tasks[index].description,
                style: const TextStyle(
                  color: Color.fromARGB(255, 82, 80, 80),
                  fontSize: 15,
                ),
              ),
              //trailing: Text(tasks[index].deadline),
              onLongPress: () {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Title Details",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text("Title: ${tasks[index].taskName}"),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Description: ${tasks[index].description}"),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Days Required: ${tasks[index].deadline}"),
                              const SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    tasks.removeAt(index);
                                    if (mounted) {
                                      setState(() {});
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"))
                            ],
                          ),
                        ),
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }

  void addTask() {
    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text('Add Task'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: taskNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Task Name',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionController,
                      style: const TextStyle(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Description',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: deadlineController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Days Required',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (taskNameController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty &&
                        deadlineController.text.isNotEmpty) {
                      setState(() {
                        tasks.add(TASK(
                            taskNameController.text,
                            descriptionController.text,
                            deadlineController.text));
                      });
                      taskNameController.clear();
                      descriptionController.clear();
                      deadlineController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        });
  }
}

class TASK {
  String taskName;
  String description;
  String deadline;
  TASK(this.taskName, this.description, this.deadline);
}
