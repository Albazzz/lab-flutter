import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../services/database_helper.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';
import '../widgets/task_item.dart';
import '../widgets/task_statistics.dart';
import '../widgets/empty_state.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _filter = 'All';
  String _searchQuery = '';
  DateTime? _selectedDeadline;
  TaskDifficulty _selectedDifficulty = TaskDifficulty.easy;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() async {
    final tasks = await _dbHelper.getTasks();
    final username = await AuthService.getUsername();
    setState(() {
      _tasks = tasks;
      _username = username;
    });
  }

  void _addTask() async {
    final title = _taskController.text.trim();
    if (title.isNotEmpty) {
      final newTask = Task(
        title: title,
        createdAt: DateTime.now(),
        deadline: _selectedDeadline,
        difficulty: _selectedDifficulty,
      );
      int id = await _dbHelper.insertTask(newTask);
      newTask.id = id;
      
      setState(() {
        _tasks.insert(0, newTask);
        _taskController.clear();
        _selectedDeadline = null;
        _selectedDifficulty = TaskDifficulty.easy;
      });
    }
  }

  void _toggleTask(Task task) async {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
    await _dbHelper.updateTask(task);
  }

  void _deleteTask(Task task) {
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
            onPressed: () async {
              if (task.id != null) {
                await _dbHelper.deleteTask(task.id!);
                setState(() {
                  _tasks.removeWhere((t) => t.id == task.id);
                });
              }
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editTask(Task task, String newTitle, DateTime? newDeadline, TaskDifficulty newDifficulty) async {
    setState(() {
      task.title = newTitle;
      task.deadline = newDeadline;
      task.difficulty = newDifficulty;
    });
    await _dbHelper.updateTask(task);
  }

  void _logout() async {
    await AuthService.logout();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  List<Task> get _filteredTasks {
    List<Task> filtered = _tasks;
    
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((task) => 
        task.title.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi, ${_username ?? "User"}', style: AppleTypography.bodyStrong),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: AppleColors.primary),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppleSpacing.lg),
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
                        Row(
                          children: [
                            const Text('Difficulty:', style: AppleTypography.captionStrong),
                            const SizedBox(width: AppleSpacing.sm),
                            ...TaskDifficulty.values.map((d) => Padding(
                              padding: const EdgeInsets.only(right: AppleSpacing.xs),
                              child: ChoiceChip(
                                label: Text(d.name[0].toUpperCase() + d.name.substring(1)),
                                selected: _selectedDifficulty == d,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() => _selectedDifficulty = d);
                                  }
                                },
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(height: AppleSpacing.sm),
                        GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (date != null) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                setState(() {
                                  _selectedDeadline = DateTime(
                                    date.year, date.month, date.day,
                                    time.hour, time.minute,
                                  );
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppleSpacing.md,
                              vertical: AppleSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: AppleColors.canvasParchment,
                              borderRadius: BorderRadius.circular(AppleRadius.md),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 18, color: AppleColors.primary),
                                const SizedBox(width: AppleSpacing.sm),
                                Text(
                                  _selectedDeadline == null
                                      ? 'Set Deadline (Optional)'
                                      : 'Deadline: ${DateFormat('dd/MM/yyyy HH:mm').format(_selectedDeadline!)}',
                                  style: AppleTypography.caption.copyWith(
                                    color: _selectedDeadline == null ? Colors.grey : AppleColors.primary,
                                  ),
                                ),
                                if (_selectedDeadline != null)
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 16),
                                    onPressed: () => setState(() => _selectedDeadline = null),
                                  ),
                              ],
                            ),
                          ),
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
                  Wrap(
                    spacing: AppleSpacing.xs,
                    runSpacing: AppleSpacing.xs,
                    children: [
                      _buildFilterChip('All'),
                      _buildFilterChip('Completed'),
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
                            onDelete: () => _deleteTask(task),
                            onEdit: (newTitle, newDeadline, newDifficulty) => 
                                _editTask(task, newTitle, newDeadline, newDifficulty),
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
