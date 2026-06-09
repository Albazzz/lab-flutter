import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../utils/constants.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(String, DateTime?, TaskDifficulty) onEdit;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  Color _getDifficultyColor(TaskDifficulty difficulty) {
    switch (difficulty) {
      case TaskDifficulty.easy:
        return AppleColors.easyGreen;
      case TaskDifficulty.medium:
        return AppleColors.mediumOrange;
      case TaskDifficulty.hard:
        return AppleColors.hardRed;
    }
  }

  String _getDifficultyText(TaskDifficulty difficulty) {
    switch (difficulty) {
      case TaskDifficulty.easy:
        return 'Easy';
      case TaskDifficulty.medium:
        return 'Medium';
      case TaskDifficulty.hard:
        return 'Hard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppleSpacing.sm),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppleColors.dividerSoft),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppleSpacing.sm,
          vertical: AppleSpacing.xs,
        ),
        leading: GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: task.isCompleted ? AppleColors.primary : Colors.grey.shade400,
                width: 2,
              ),
              color: task.isCompleted ? AppleColors.primary : Colors.transparent,
            ),
            child: task.isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                task.title,
                style: AppleTypography.bodyStrong.copyWith(
                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  color: task.isCompleted ? Colors.grey : AppleColors.ink,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getDifficultyColor(task.difficulty).withValues(alpha: 0.1),
                borderRadius: AppleRadius.pill,
              ),
              child: Text(
                _getDifficultyText(task.difficulty),
                style: AppleTypography.microLegal.copyWith(
                  color: _getDifficultyColor(task.difficulty),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.deadline != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 14, color: AppleColors.hardRed),
                    const SizedBox(width: 4),
                    Text(
                      'Deadline: ${DateFormat('dd/MM/yyyy HH:mm').format(task.deadline!)}',
                      style: AppleTypography.caption.copyWith(color: AppleColors.hardRed),
                    ),
                  ],
                ),
              ),
            Text(
              'Created: ${DateFormat('dd/MM/yyyy HH:mm').format(task.createdAt)}',
              style: AppleTypography.body.copyWith(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              onPressed: () => _showEditDialog(context),
              color: AppleColors.primary,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: onDelete,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    DateTime? selectedDeadline = task.deadline;
    TaskDifficulty selectedDifficulty = task.difficulty;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Task title'),
                ),
                const SizedBox(height: 16),
                const Text('Difficulty', style: AppleTypography.captionStrong),
                Row(
                  children: TaskDifficulty.values.map((d) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(_getDifficultyText(d)),
                        selected: selectedDifficulty == d,
                        onSelected: (selected) {
                          if (selected) {
                            setDialogState(() => selectedDifficulty = d);
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text('Deadline', style: AppleTypography.captionStrong),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    selectedDeadline == null
                        ? 'No deadline'
                        : DateFormat('dd/MM/yyyy HH:mm').format(selectedDeadline!),
                    style: AppleTypography.caption,
                  ),
                  trailing: const Icon(Icons.calendar_today, size: 18),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDeadline ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDeadline ?? DateTime.now()),
                      );
                      if (time != null) {
                        setDialogState(() {
                          selectedDeadline = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  onEdit(titleController.text.trim(), selectedDeadline, selectedDifficulty);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
