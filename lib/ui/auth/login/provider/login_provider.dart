import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/model/form/login.dart';
import 'package:pokedex/ui/widget/snackbar.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController? emailCtrl, passCtrl;

  final storage = GetStorage();

  var togglePassword = false;
  var isLoading = false;

  final form = LoginForm();
  final _errors = <String, String>{};

  String? getErrorMessage(String key) {
    if (_errors.containsKey(key)) {
      return _errors[key];
    }
    return null;
  }

  removeErrorMessage(String key) {
    if (_errors.containsKey(key)) {
      notifyListeners();
      return _errors.remove(key);
    }
  }

  updateValue(String key, String value) {
    removeErrorMessage(key);
    switch (key) {
      case LoginForm.EMAIL:
        form.email = value;
        break;
      case LoginForm.PASSWORD:
        form.password = value;
        break;
    }
  }

  bool validate() {
    _errors.clear();
    var valid = true;
    var email = form.email ?? '';
    var password = form.password ?? '';

    if (email.isEmpty) {
      valid = false;
      _errors[LoginForm.EMAIL] = 'Email cannot be empty';
      notifyListeners();
    }

    if (password.isEmpty) {
      valid = false;
      _errors[LoginForm.PASSWORD] = 'Password cannot be empty';
      notifyListeners();
    }

    return valid;
  }

  toggle(){
    if(togglePassword){
      togglePassword = false;
      notifyListeners();
    }else{
      togglePassword = true;
      notifyListeners();
    }
  }

  doLogin(BuildContext context) {
    if (validate()) {
      if (storage.hasData(kAuthToken)) {
        isLoading = true;
        notifyListeners();
        var data = jsonDecode(storage.read(kAuthToken));

        for (var element in data) {
          if (element['email'] == form.email && element['password'] == form.password) {
            Future.delayed(Duration(seconds: 1), () {
              isLoading = false;
              notifyListeners();
              storage.write(kLastLogin, element['email']);
              Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
            });
          } else {
            isLoading = false;
            notifyListeners();
            showSnackBar('Wrong email or password');
          }
        }
      }else{
        showSnackBar('Email is not registered');
      }
    }
  }
}
