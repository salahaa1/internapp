import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_bloc.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_event.dart';

class TaskDetailsActionButtons extends StatelessWidget {
  final int taskId;

  const TaskDetailsActionButtons({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFE8BBBB),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Center(child: Text("تعديل المهمة")),
          ),
        ),
        const SizedBox(width: 16),

        GestureDetector(
          onTap: () {
            context.read<TaskListBloc>().add(DeleteTaskEvent(taskId));

            Navigator.pop(context);
          },
          child: Container(
            width: 120,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete_outline),
                SizedBox(width: 8),
                Text("حذف"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
