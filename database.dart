// lib/services/db_service.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'task_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        category TEXT,
        isCompleted INTEGER NOT NULL,
        reminderTime INTEGER
      )
    ''');
  }

  Future<void> addTask(Task task) async {
    final db = await instance.database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> fetchTasks() async {
    final db = await instance.database;
    final maps = await db.query('tasks');
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<void> updateTask(Task task) async {
    final db = await instance.database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await instance.database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
