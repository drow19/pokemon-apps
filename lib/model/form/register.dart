class RegisterForm {
  static const String USERNAME = 'username';
  static const String EMAIL = 'email';
  static const String PASSWORD = 'password';

  String? username, password, email;

  RegisterForm() {
    username = '';
    email = '';
    password = '';
  }

  clearData() {
    username = '';
    email = '';
    password = '';
  }

  Map<String, dynamic> register() {
    Map<String, dynamic> map = {
      USERNAME: username,
      PASSWORD: password,
      EMAIL: email
    };

    return map;
  }
}
