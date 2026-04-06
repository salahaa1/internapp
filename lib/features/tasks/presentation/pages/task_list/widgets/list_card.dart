// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';
import 'package:tasks_project/features/tasks/domin/intities/task.dart';

class TaskOverviewCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskOverviewCard({super.key, required this.task, required this.onTap});

  String _priorityLabel() {
    switch (task.priority.toLowerCase()) {
      case 'high':
        return 'عالية';
      case 'medium':
        return 'متوسطة';
      case 'low':
        return 'منخفضة';
      default:
        return task.priority;
    }
  }

  String _statusLabel() {
    switch (task.statusId) {
      case 2:
        return 'تم الإنجاز';
      case 3:
        return 'قيد التنفيذ';
      default:
        return 'قيد الانتظار';
    }
  }

  Color _priorityBg() {
    switch (task.priority.toLowerCase()) {
      case 'high':
        return const Color(0xFFF7D2CC);
      case 'medium':
        return const Color.fromARGB(255, 225, 224, 218);
      case 'low':
        return const Color.fromARGB(255, 164, 220, 201);
      default:
        return AppColors.primary.withOpacity(0.10);
    }
  }

  String _dateText() {
    return task.dueDate.isNotEmpty ? task.dueDate : task.startDate;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(34),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            task.taskName,
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: _priorityBg(),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            _priorityLabel(),
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF7B5557),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 15,
                          color: Color(0xFF6E6E6E),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _dateText(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6E6E6E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 10,
                          color: Color(0xFFB7B7B7),
                        ),
                        const SizedBox(width: 10),

                        Text(
                          _statusLabel(),
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7B5557),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
