import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/constants.dart';
import '../widgets/task_item.dart';
import '../widgets/task_statistics.dart';
import '../widgets/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _filter = 'All';
  String _searchQuery = '';

  void _addTask() {
    final title = _taskController.text.trim();
    if (title.isNotEmpty) {
      setState(() {
        _tasks.insert(0, Task(title: title, createdAt: DateTime.now()));
        _taskController.clear();
      });
    }
  }

  void _toggleTask(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _tasks.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editTask(Task task, String newTitle) {
    setState(() {
      task.title = newTitle;
    });
  }

  List<Task> get _filteredTasks {
    List<Task> filtered = _tasks;
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((task) => 
        task.title.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    // Filter by status
    if (_filter == 'Completed') {
      return filtered.where((task) => task.isCompleted).toList();
    } else if (_filter == 'Incomplete') {
      return filtered.where((task) => !task.isCompleted).toList();
    }
    return filtered;
  }

  int get _completedCount => _tasks.where((task) => task.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppleColors.canvasParchment,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(AppleSpacing.lg),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const Text('TODO MANAGER', style: AppleTypography.displayLg),
                  const SizedBox(height: AppleSpacing.xl),
                  
                  // Search Bar
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppleColors.canvas,
                      borderRadius: AppleRadius.pill,
                      border: Border.all(color: AppleColors.hairline),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: AppleSpacing.md),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey, size: 20),
                        const SizedBox(width: AppleSpacing.xs),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (val) => setState(() => _searchQuery = val),
                            decoration: const InputDecoration(
                              hintText: 'Search task...',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            style: AppleTypography.body,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppleSpacing.lg),

                  // Input Section
                  Container(
                    padding: const EdgeInsets.all(AppleSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppleColors.canvas,
                      borderRadius: BorderRadius.circular(AppleRadius.lg),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('New Task', style: AppleTypography.bodyStrong),
                        const SizedBox(height: AppleSpacing.sm),
                        TextField(
                          controller: _taskController,
                          decoration: InputDecoration(
                            hintText: 'What needs to be done?',
                            filled: true,
                            fillColor: AppleColors.canvasParchment,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppleRadius.md),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppleSpacing.md,
                              vertical: AppleSpacing.sm,
                            ),
                          ),
                          style: AppleTypography.body,
                        ),
                        const SizedBox(height: AppleSpacing.md),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _addTask,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppleColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('Add Task', style: AppleTypography.bodyStrong),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppleSpacing.lg),

                  // Statistics
                  TaskStatistics(
                    total: _tasks.length,
                    completed: _completedCount,
                  ),
                  const SizedBox(height: AppleSpacing.lg),

                  // Filter Chips
                  Row(
                    children: [
                      _buildFilterChip('All'),
                      const SizedBox(width: AppleSpacing.xs),
                      _buildFilterChip('Completed'),
                      const SizedBox(width: AppleSpacing.xs),
                      _buildFilterChip('Incomplete'),
                    ],
                  ),
                  const SizedBox(height: AppleSpacing.md),
                ]),
              ),
            ),

            // Task List
            _filteredTasks.isEmpty
                ? const SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppleSpacing.lg),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final task = _filteredTasks[index];
                          return TaskItem(
                            task: task,
                            onToggle: () => _toggleTask(task),
                            onDelete: () => _deleteTask(_tasks.indexOf(task)),
                            onEdit: (newTitle) => _editTask(task, newTitle),
                          );
                        },
                        childCount: _filteredTasks.length,
                      ),
                    ),
                  ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _filter == label;
    return GestureDetector(
      onTap: () => setState(() => _filter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppleSpacing.md,
          vertical: AppleSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppleColors.ink : AppleColors.canvas,
          borderRadius: AppleRadius.pill,
          border: Border.all(
            color: isSelected ? AppleColors.ink : AppleColors.hairline,
          ),
        ),
        child: Text(
          label,
          style: AppleTypography.caption.copyWith(
            color: isSelected ? Colors.white : AppleColors.ink,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
