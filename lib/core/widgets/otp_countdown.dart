import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class OtpCountdown extends StatefulWidget {
  final int seconds;
  final Future<void> Function() onResend;

  const OtpCountdown({super.key, this.seconds = 60, required this.onResend});

  @override
  State<OtpCountdown> createState() => _OtpCountdownState();
}

class _OtpCountdownState extends State<OtpCountdown> {
  Timer? _timer;
  late int _remaining;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _remaining = widget.seconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining <= 0) {
        timer.cancel();
      } else {
        setState(() {
          _remaining--;
        });
      }
    });
  }

  Future<void> _handleResend() async {
    if (_remaining > 0 || _isResending) return;

    setState(() {
      _isResending = true;
    });

    await widget.onResend();

    setState(() {
      _isResending = false;
      _remaining = widget.seconds;
    });

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canResend = _remaining == 0 && !_isResending;

    return Column(
      children: [
        Text(
          canResend
              ? 'يمكنك إعادة إرسال الرمز الآن'
              : 'إعادة الإرسال خلال $_remaining ثانية',
          style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: canResend ? _handleResend : null,
          child: _isResending
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  'إعادة إرسال الرمز',
                  style: AppTextStyles.body1.copyWith(
                    color: canResend ? AppColors.primary : AppColors.hint,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ],
    );
  }
}
