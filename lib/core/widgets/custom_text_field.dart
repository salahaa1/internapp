import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextDirection textDirection;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.maxLength,
    this.textDirection = TextDirection.rtl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.fieldLabel),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          maxLength: maxLength,
          textDirection: textDirection,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            suffixIcon: suffixIcon,
            hintTextDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}
