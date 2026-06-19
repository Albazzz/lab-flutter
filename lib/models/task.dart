enum TaskDifficulty { easy, medium, hard }

class Task {
  int? id;
  String? userId; // Add userId to associate task with a specific account
  String title;
  bool isCompleted;
  DateTime createdAt;
  DateTime? deadline;
  TaskDifficulty difficulty;

  Task({
    this.id,
    this.userId,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    this.deadline,
    this.difficulty = TaskDifficulty.easy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
      'difficulty': difficulty.name,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
      deadline: map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      difficulty: TaskDifficulty.values.firstWhere((e) => e.name == map['difficulty']),
    );
  }
}
