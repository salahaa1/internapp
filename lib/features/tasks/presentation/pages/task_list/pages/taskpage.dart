// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';
import 'package:tasks_project/core/di/injection_container.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_bloc.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_event.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_state.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/post_task/create_task_bloc.dart';
import 'package:tasks_project/features/tasks/presentation/pages/creat_task/add_task.dart';
import 'package:tasks_project/features/tasks/presentation/pages/ditails/task_details_page.dart';
import 'package:tasks_project/features/tasks/presentation/pages/task_list/widgets/list_card.dart';
import 'package:tasks_project/features/tasks/presentation/pages/task_list/widgets/task_appbar.dart';
import 'package:tasks_project/features/tasks/presentation/pages/task_list/widgets/task_header.dart';
import 'package:tasks_project/features/tasks/presentation/pages/task_list/widgets/tasks_summary_section.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TaskListBloc>()..add(FetchTasks()),
      child: const TasksView(),
    );
  }
}

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 200) {
      context.read<TaskListBloc>().add(FetchNextPage());
    }
  }

  Future<void> _onRefresh() async {
    context.read<TaskListBloc>().add(RefreshTasks());
  }

  void _openAddTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<TaskListBloc>()),
            BlocProvider(create: (_) => sl<CreateTaskBloc>()),
          ],
          child: const AddTaskPage(),
        ),
      ),
    );
  }

  int _completedCount(List tasks) {
    return tasks.where((e) => e.statusId == 2).length;
  }

  int _pendingCount(List tasks) {
    return tasks.where((e) => e.statusId != 2).length;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // bottomNavigationBar: const TasksBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: _openAddTask,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(0.18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(Icons.add, color: AppColors.textPrimary, size: 34),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TaskListBloc, TaskListState>(
          builder: (context, state) {
            final tasks = state is TaskListLoaded ? state.tasks : [];

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 110),
                children: [
                  const TasksHomeAppBar(),

                  // const SizedBox(height: 28),
                  // const Text(
                  //   '',
                  //   textAlign: TextAlign.right,
                  //   style: TextStyle(
                  //     fontFamily: 'Tajawal',
                  //     fontSize: 34,
                  //     fontWeight: FontWeight.w700,
                  //     color: Color(0xFF7B5557),
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  const SizedBox(height: 26),
                  TasksSummarySection(
                    completedCount: _completedCount(tasks),
                    pendingCount: _pendingCount(tasks),
                  ),
                  const SizedBox(height: 30),
                  const TasksSectionHeader(),
                  const SizedBox(height: 18),

                  if (state is TaskListLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Center(child: CircularProgressIndicator()),
                    ),

                  if (state is TaskListError)
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                  if (state is TaskListLoaded && state.tasks.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          'لا توجد مهام حالية',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                    ),

                  if (state is TaskListLoaded) ...[
                    ...state.tasks.map(
                      (task) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: TaskOverviewCard(
                          task: task,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<TaskListBloc>(),
                                  child: TaskDetailsPage(task: task),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (state.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
