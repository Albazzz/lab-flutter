enum TaskDifficulty { easy, medium, hard }

class Task {
  String title;
  bool isCompleted;
  DateTime createdAt;
  DateTime? deadline;
  TaskDifficulty difficulty;

  Task({
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    this.deadline,
    this.difficulty = TaskDifficulty.easy,
  });
}
