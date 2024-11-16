// lib/controllers/task_controller.dart
import 'package:get/get.dart';
import 'package:smart_task_manager/models/task_model.dart';
import 'package:smart_task_manager/services/db_service.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  final dbService = DatabaseService.instance;

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  Future<void> fetchTasks() async {
    taskList.value = await dbService.fetchTasks();
  }

  Future<void> addTask(Task task) async {
    await dbService.addTask(task);
    fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await dbService.updateTask(task);
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await dbService.deleteTask(id);
    fetchTasks();
  }
}
