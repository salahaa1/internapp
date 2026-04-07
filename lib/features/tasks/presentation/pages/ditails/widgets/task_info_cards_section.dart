// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tasks_project/features/tasks/domin/intities/task.dart';

class TaskInfoCardsSection extends StatelessWidget {
  final Task task;

  const TaskInfoCardsSection({super.key, required this.task});

  String _priorityText() {
    switch (task.priority.toLowerCase()) {
      case 'high':
        return 'عالية ';
      case 'medium':
        return 'متوسطة';
      case 'low':
        return 'منخفضة';
      default:
        return task.priority;
    }
  }

  String _statusText() {
    switch (task.statusId) {
      case 2:
        return 'تم الإنجاز';
      case 3:
        return 'قيد التنفيذ';
      default:
        return 'قيد الانتظار';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7B5557).withOpacity(0.05),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Color(0xFF7B5557),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'المواعيد الزمنية',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF7B5557),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Text(
                    'تاريخ البدء',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 17,
                      color: Color(0xFF555555),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    task.startDate,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'تاريخ الاستحقاق',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 14,
                      color: Color(0xFF555555),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    task.dueDate,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7B5557),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7B5557).withOpacity(0.05),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'الأولوية',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      color: Color(0xFF555555),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4DADB),
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Text(
                      _priorityText(),
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7B5557),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Text(
                    'الحالة',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      color: Color(0xFF555555),
                    ),
                  ),
                  const Spacer(),

                  Text(
                    _statusText(),
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF7B5557),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
