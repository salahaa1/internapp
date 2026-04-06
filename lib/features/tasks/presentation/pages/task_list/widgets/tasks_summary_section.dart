// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';

class TasksSummarySection extends StatelessWidget {
  final int completedCount;
  final int pendingCount;

  const TasksSummarySection({
    super.key,
    required this.completedCount,
    required this.pendingCount,
  });

  String _todayMonth() {
    final now = DateTime.now();
    final months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return '${now.day} ${months[now.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 11,
          child: Container(
            height: 190,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(34),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.bolt, color: const Color(0xFF7B5557), size: 30),
                const Spacer(),
                Text(
                  '$completedCount',
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7B5557),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'مهمة منجزة',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7B5557),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          flex: 10,
          child: Column(
            children: [
              Container(
                height: 90,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'قيد الانتظار',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$pendingCount',
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7B5557),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4E7E7),
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: Icon(
                        Icons.calendar_month,
                        color: const Color(0xFF6F7477),
                        size: 20,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'التاريخ',
                            textDirection: TextDirection.rtl,

                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),

                          Text(
                            _todayMonth(),
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF585858),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
