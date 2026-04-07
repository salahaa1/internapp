// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';
import 'package:tasks_project/features/tasks/domin/intities/task.dart';
import 'package:tasks_project/features/tasks/presentation/pages/ditails/widgets/task_deitails_action_button.dart';
import 'package:tasks_project/features/tasks/presentation/pages/ditails/widgets/task_info_cards_section.dart';
import 'package:tasks_project/features/tasks/presentation/pages/ditails/widgets/task_progress_section.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 18),
              const TaskProgressSection(progress: 75),
              const SizedBox(height: 16),

              const SizedBox(height: 18),
              Text(
                task.taskName,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF7B5557),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                task.description,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4F4F4F),
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 24),
              TaskInfoCardsSection(task: task),
              const SizedBox(height: 18),
              TaskDetailsActionButtons(taskId: task.id),
              const SizedBox(height: 28),
              // const TaskDiscussionSection(),
              // const SizedBox(height: 18),
              // const TaskDiscussionInput(),
            ],
          ),
        ),
      ),
    );
  }
}
