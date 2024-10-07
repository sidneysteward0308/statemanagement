import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = []; // List to store tasks

  // Method to add a task
  void addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));
    });
  }

  // Method to mark a task as completed/incomplete
  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  // Method to remove a task
  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager App'),
      ),
      body: Column(
        children: [
          // Text input field and "Add" button
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter task name',
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                addTask(value);
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Open a dialog to add a task
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Task'),
                    content: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter task name',
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          addTask(value);
                          Navigator.pop(context); // Close the dialog
                        }
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          // Add task when "Add" is pressed in the dialog
                          
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Add'),
          ),
          // Task list
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (value) {
                      toggleTaskCompletion(index);
                    },
                  ),
                  title: Text(tasks[index].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      removeTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}