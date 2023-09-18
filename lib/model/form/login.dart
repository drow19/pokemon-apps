class LoginForm {
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';

  String? password, email;

  RegisterForm() {
    email = '';
    password = '';
  }

  Map<String, dynamic> login() {
    Map<String, dynamic> map = {PASSWORD: password, EMAIL: email};

    return map;
  }
}