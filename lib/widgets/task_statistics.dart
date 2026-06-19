import 'package:flutter/material.dart';
import '../utils/constants.dart';

class TaskStatistics extends StatelessWidget {
  final int total;
  final int completed;

  const TaskStatistics({
    super.key,
    required this.total,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppleSpacing.lg),
      decoration: BoxDecoration(
        color: AppleColors.canvas,
        borderRadius: BorderRadius.circular(AppleRadius.lg),
        border: Border.all(color: AppleColors.hairline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', total.toString()),
          _buildStatItem('Completed', completed.toString()),
          _buildStatItem('Remaining', (total - completed).toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppleTypography.displayLg.copyWith(fontSize: 32),
        ),
        Text(
          label,
          style: AppleTypography.caption.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
