import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';
import 'package:tasks_project/core/Theme/app_text_styles.dart';
import 'package:tasks_project/core/di/injection_container.dart';
import 'package:tasks_project/core/widgets/custom_button.dart';
import 'package:tasks_project/core/widgets/custom_text_field.dart';
import 'package:tasks_project/features/auth/presntation/bloc/regster/register_bloc.dart';
import 'package:tasks_project/features/auth/presntation/bloc/regster/register_state.dart';
import 'package:tasks_project/features/auth/presntation/bloc/regster/regster_event.dart';
import 'package:tasks_project/features/auth/presntation/pages/login/loginpage.dart';
import 'package:tasks_project/features/auth/presntation/pages/register/register_page_logic.dart';
import 'package:tasks_project/features/auth/presntation/pages/verify/verifypage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<RegisterBloc>().add(
      RegisterSubmitted(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        passwordConfirmation: confirmPasswordController.text.trim(),
        mobileNo: mobileController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterBloc>(),
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
              'حساب جديد',
              style: AppTextStyles.headline1,
              textAlign: TextAlign.right,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                ),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        VerifyEmailPage(email: emailController.text.trim()),
                  ),
                );
              }

              if (state is RegisterError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final isLoading = state is RegisterLoading;

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
                      const SizedBox(height: 28),
                      CustomTextField(
                        controller: nameController,
                        label: 'الاسم كامل',
                        hintText: 'ادخل اسمك الكامل',
                        validator: RegisterPageLogic.validateName,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: emailController,
                        label: 'البريد الالكتروني',
                        hintText: 'ادخل البريد الالكتروني',
                        keyboardType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        validator: RegisterPageLogic.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: mobileController,
                        label: 'رقم الهاتف',
                        hintText: 'ادخل رقم الهاتف',
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        validator: RegisterPageLogic.validatePhone,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: passwordController,
                        label: 'كلمة المرور',
                        hintText: 'ادخل كلمة المرور',
                        obscureText: true,
                        textDirection: TextDirection.ltr,
                        validator: RegisterPageLogic.validatePassword,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: confirmPasswordController,
                        label: 'تأكيد كلمة المرور',
                        hintText: 'ادخل كلمة المرور',
                        obscureText: true,
                        textDirection: TextDirection.ltr,
                        validator: (value) =>
                            RegisterPageLogic.validateConfirmPassword(
                              value,
                              passwordController.text,
                            ),
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        title: 'سجل',
                        isLoading: isLoading,
                        onPressed: () => _submit(context),
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
