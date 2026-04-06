class VerifyEmailPageLogic {
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رمز التحقق مطلوب';
    }

    if (value.trim().length != 6) {
      return 'رمز التحقق يجب أن يكون 6 أرقام';
    }

    return null;
  }
}
