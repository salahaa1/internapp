import 'package:flutter/material.dart';

class TasksSectionHeader extends StatelessWidget {
  const TasksSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'المهام الحالية',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        Spacer(),
        Text(
          'عرض الكل',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF7B5557),
          ),
        ),
      ],
    );
  }
}
