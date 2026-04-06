class LoginPageLogic {
  static String? validateLogin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    final email = value.trim();

    final emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,}$');

    if (!email.contains('@')) {
      return 'يجب أن يحتوي البريد على @';
    }

    if (!email.contains('.')) {
      return 'البريد الإلكتروني غير صحيح';
    }

    if (!emailRegex.hasMatch(email)) {
      return 'البريد الإلكتروني غير صحيح';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }

    return null;
  }
}
