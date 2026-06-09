import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.assignment_outlined,
            size: 64,
            color: AppleColors.bodyMuted,
          ),
          const SizedBox(height: AppleSpacing.md),
          Text(
            'No tasks yet',
            style: AppleTypography.tagline.copyWith(color: AppleColors.ink),
          ),
          const SizedBox(height: AppleSpacing.xs),
          Text(
            'Add your first task above',
            style: AppleTypography.body.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
