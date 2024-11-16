// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Task Manager")),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.taskList.length,
          itemBuilder: (context, index) {
            final task = taskController.taskList[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskController.updateTask(
                    Task(
                      id: task.id,
                      title: task.title,
                      description: task.description,
                      category: task.category,
                      isCompleted: value!,
                      reminderTime: task.reminderTime,
                    ),
                  );
                },
              ),
              onLongPress: () => taskController.deleteTask(task.id!),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigate to task input form
        },
      ),
    );
  }
}
