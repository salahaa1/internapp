// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';

class TasksHomeAppBar extends StatelessWidget {
  const TasksHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withOpacity(0.35),
              width: 2,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: AppColors.white,
            child: Icon(Icons.person, size: 30, color: AppColors.textSecondary),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'مهامي',
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF7B5557),
            ),
          ),
        ),
        const Spacer(),
        Icon(Icons.menu, size: 32, color: const Color(0xFF7B5557)),
      ],
    );
  }
}
