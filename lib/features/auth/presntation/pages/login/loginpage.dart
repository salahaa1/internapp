import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';
import 'package:tasks_project/core/Theme/app_text_styles.dart';
import 'package:tasks_project/core/di/injection_container.dart';
import 'package:tasks_project/core/widgets/custom_button.dart';
import 'package:tasks_project/core/widgets/custom_text_field.dart';
import 'package:tasks_project/features/auth/presntation/bloc/login/login_bloc.dart';
import 'package:tasks_project/features/auth/presntation/bloc/login/login_event.dart';
import 'package:tasks_project/features/auth/presntation/bloc/login/login_state.dart';
import 'package:tasks_project/features/auth/presntation/pages/login/login_page_logic.dart';
import 'package:tasks_project/features/auth/presntation/pages/register/registerpage.dart';
import 'package:tasks_project/features/tasks/presentation/pages/task_list/pages/taskpage.dart';
import 'package:tasks_project/features/auth/presntation/pages/verify/verifypage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginBloc>().add(
      LoginSubmitted(
        login: loginController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.background,
        ),
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const TasksPage()),
                );
              }

              if (state is LoginUnverified) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        VerifyEmailPage(email: loginController.text.trim()),
                  ),
                );
              }

              if (state is LoginError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final isLoading = state is LoginLoading;

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
                      const SizedBox(height: 48),
                      Center(
                        child: Text(
                          'مرحباً بك 👋',
                          style: AppTextStyles.headline1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          'تسجيل الدخول',
                          style: AppTextStyles.body1.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      CustomTextField(
                        controller: loginController,
                        label: 'البريد الالكتروني',
                        hintText: 'ادخل البريد الالكتروني',
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        validator: LoginPageLogic.validateLogin,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: passwordController,
                        label: 'كلمة المرور',
                        hintText: 'ادخل كلمة المرور',
                        obscureText: true,
                        textDirection: TextDirection.ltr,
                        validator: LoginPageLogic.validatePassword,
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        title: 'تسجيل دخول',
                        isLoading: isLoading,
                        onPressed: () => _submit(context),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Text("حساب جديد؟ سجل الان"),
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
