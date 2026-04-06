import 'package:flutter/material.dart';
import 'package:tasks_project/core/Theme/app_colors.dart' show AppColors;
import 'package:tasks_project/core/Theme/app_text_styles.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_state.dart';
import 'package:tasks_project/features/tasks/presentation/pages/task_list/widgets/list_card.dart';

class TasksBody extends StatelessWidget {
  final TaskListState state;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;

  const TasksBody({
    super.key,
    required this.state,
    required this.scrollController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (state is TaskListLoading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    if (state is TaskListError) {
      return Expanded(
        child: Center(
          child: Text(
            (state as TaskListError).message,
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    if (state is TaskListLoaded) {
      final loaded = state as TaskListLoaded;

      if (loaded.tasks.isEmpty) {
        return Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 120),
                Center(
                  child: Text(
                    'لا توجد مهام',
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Expanded(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: loaded.tasks.length + (loaded.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= loaded.tasks.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final task = loaded.tasks[index];

              return TaskOverviewCard(task: task, onTap: () {});
            },
          ),
        ),
      );
    }

    return const Expanded(child: SizedBox());
  }
}
