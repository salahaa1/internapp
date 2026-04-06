import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/core/Theme/app_colors.dart';
import 'package:tasks_project/core/Theme/app_text_styles.dart';
import 'package:tasks_project/core/di/injection_container.dart';
import 'package:tasks_project/core/widgets/custom_button.dart';
import 'package:tasks_project/core/widgets/custom_text_field.dart';
import 'package:tasks_project/core/widgets/otp_countdown.dart';
import 'package:tasks_project/features/auth/presntation/bloc/resendverification/resendverificarion_event.dart';
import 'package:tasks_project/features/auth/presntation/bloc/resendverification/resendverification_bloc.dart';
import 'package:tasks_project/features/auth/presntation/bloc/resendverification/resendverification_state.dart';
import 'package:tasks_project/features/auth/presntation/bloc/verifyEmail/verify_email_bloc.dart';
import 'package:tasks_project/features/auth/presntation/bloc/verifyEmail/verify_email_event.dart';
import 'package:tasks_project/features/auth/presntation/bloc/verifyEmail/verify_email_state.dart';
import 'package:tasks_project/features/auth/presntation/pages/login/loginpage.dart';
import 'package:tasks_project/features/auth/presntation/pages/verify/verify_email_page_logic.dart';

class VerifyEmailPage extends StatefulWidget {
  final String email;

  const VerifyEmailPage({super.key, required this.email});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<VerifyEmailBloc>().add(
      VerifyEmailSubmitted(
        email: widget.email,
        code: codeController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<VerifyEmailBloc>()),
        BlocProvider(create: (_) => sl<ResendVerificationBloc>()),
      ],
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
              '',
              style: AppTextStyles.headline1,
              textAlign: TextAlign.right,
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
          child: MultiBlocListener(
            listeners: [
              BlocListener<VerifyEmailBloc, VerifyEmailState>(
                listener: (context, state) {
                  if (state is VerifyEmailSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  }

                  if (state is VerifyEmailWrongCode) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }

                  if (state is VerifyEmailExpiredCode) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }

                  if (state is VerifyEmailError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
              BlocListener<ResendVerificationBloc, ResendVerificationState>(
                listener: (context, state) {
                  if (state is ResendVerificationSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }

                  if (state is ResendVerificationError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
            ],
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: AppColors.border, thickness: 1),
                    const SizedBox(height: 48),
                    Center(child: Text('OTP', style: AppTextStyles.headline1)),
                    const SizedBox(height: 32),
                    CustomTextField(
                      controller: codeController,
                      label: 'رمز التحقق',
                      hintText: 'ادخل رمز التحقق',
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      maxLength: 6,
                      validator: VerifyEmailPageLogic.validateOtp,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
                      builder: (context, state) {
                        return CustomButton(
                          title: 'تأكيد',
                          isLoading: state is VerifyEmailLoading,
                          onPressed: () => _submit(context),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: OtpCountdown(
                        onResend: () async {
                          context.read<ResendVerificationBloc>().add(
                            ResendVerificationSubmitted(email: widget.email),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
