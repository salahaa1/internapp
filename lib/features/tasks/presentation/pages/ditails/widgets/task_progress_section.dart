// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';

class TaskProgressSection extends StatelessWidget {
  final int progress;

  const TaskProgressSection({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220,
        height: 110,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: progress / 100,
                strokeWidth: 14,
                backgroundColor: AppColors.primary.withOpacity(0.12),
                valueColor: AlwaysStoppedAnimation(
                  AppColors.primary.withOpacity(0.35),
                ),
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$progress%',
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7B5557),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'مكتمل',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
