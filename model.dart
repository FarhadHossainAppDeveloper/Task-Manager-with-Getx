// lib/models/task_model.dart
class Task {
  int? id;
  String title;
  String description;
  String category;
  bool isCompleted;
  DateTime? reminderTime;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.category = 'General',
    this.isCompleted = false,
    this.reminderTime,
  });

  // Convert Task to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted ? 1 : 0,
      'reminderTime': reminderTime?.millisecondsSinceEpoch,
    };
  }

  // Create Task from Map
  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      isCompleted: map['isCompleted'] == 1,
      reminderTime: map['reminderTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reminderTime'])
          : null,
    );
  }
}
