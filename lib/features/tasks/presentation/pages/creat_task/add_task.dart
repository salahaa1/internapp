import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';
import 'package:tasks_project/core/Theme/app_text_styles.dart';
import 'package:tasks_project/core/di/injection_container.dart';
import 'package:tasks_project/core/widgets/custom_button.dart';
import 'package:tasks_project/core/widgets/custom_text_field.dart';
import 'package:tasks_project/features/tasks/domin/intities/create_task_params.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_bloc.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_event.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/post_task/create_task_bloc.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/post_task/create_task_event.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/post_task/create_task_state.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final _taskNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _priority = 'Medium';
  DateTime? _startDate;
  DateTime? _dueDate;

  @override
  void dispose() {
    _taskNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_dueDate ?? DateTime.now()),
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
      locale: const Locale('ar'),
    );

    if (picked == null) return;

    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _dueDate = picked;
      }
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_startDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تاريخ البداية مطلوب')));
      return;
    }

    if (_dueDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تاريخ النهاية مطلوب')));
      return;
    }

    if (_dueDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تاريخ النهاية يجب أن يكون بعد تاريخ البداية'),
        ),
        

      );
      return ;
    }

    final params = CreateTaskParams(
      taskName: _taskNameController.text.trim(),
      description: _descriptionController.text.trim(),
      priority: _priority,
      startDate: _formatDate(_startDate),
      dueDate: _formatDate(_dueDate),
      statusId: 1,
      assignedUserIds: const [36138], 
      ownerId: 36138, 
      assignmentType: 'any_user',
      executeTaskIndividually: false,
      recurrenceType: 'None',
    );

    context.read<CreateTaskBloc>().add(CreateTaskSubmitted(params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CreateTaskBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.background,
          titleSpacing: 24,
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'إضافة مهمة',
              style: AppTextStyles.headline1.copyWith(color: AppColors.primary),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<CreateTaskBloc, CreateTaskState>(
            listener: (context, state) {
              if (state is CreateTaskSuccess) {
                context.read<TaskListBloc>().add(RefreshTasks());
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تمت إضافة المهمة بنجاح')),
                );
              }

              if (state is CreateTaskError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final isLoading = state is CreateTaskLoading;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(color: AppColors.border, thickness: 1),
                      const SizedBox(height: 24),

                      CustomTextField(
                        controller: _taskNameController,
                        label: 'اسم المهمة',
                        hintText: 'ادخل الاسم',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'اسم المهمة مطلوب';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('الوصف', style: AppTextStyles.fieldLabel),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(hintText: 'الوصف'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'الوصف مطلوب';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تحديد الأولوية',
                          style: AppTextStyles.fieldLabel,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: _priority,
                        decoration: const InputDecoration(),
                        items: const [
                          DropdownMenuItem(value: 'Low', child: Text('منخفض')),
                          DropdownMenuItem(
                            value: 'Medium',
                            child: Text('متوسط'),
                          ),
                          DropdownMenuItem(value: 'High', child: Text('عالي')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _priority = value;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تاريخ البداية',
                          style: AppTextStyles.fieldLabel,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _pickDate(isStart: true),
                        child: AbsorbPointer(
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            controller: TextEditingController(
                              text: _formatDate(_startDate),
                            ),
                            decoration: const InputDecoration(
                              hintText: 'اختر تاريخ البداية',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تاريخ الاستحقاق',
                          style: AppTextStyles.fieldLabel,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _pickDate(isStart: false),
                        child: AbsorbPointer(
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            controller: TextEditingController(
                              text: _formatDate(_dueDate),
                            ),
                            decoration: const InputDecoration(
                              hintText: 'اختر تاريخ الاستحقاق',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      CustomButton(
                        title: 'إضافة',
                        isLoading: isLoading,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
