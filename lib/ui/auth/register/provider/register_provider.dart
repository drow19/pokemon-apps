import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/model/form/register.dart';
import 'package:pokedex/ui/widget/snackbar.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class RegisterProvider extends ChangeNotifier {
  final storage = GetStorage();

  var togglePassword = false;
  final form = RegisterForm();
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
      case RegisterForm.USERNAME:
        form.username = value;
        break;
      case RegisterForm.EMAIL:
        form.email = value;
        break;
      case RegisterForm.PASSWORD:
        form.password = value;
        break;
    }
  }

  bool validate() {
    _errors.clear();
    var valid = true;
    var email = form.email ?? '';
    var name = form.username ?? '';
    var password = form.password ?? '';

    var regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (name.isEmpty) {
      valid = false;
      _errors[RegisterForm.USERNAME] = 'Username cannot be empty';
      notifyListeners();
    }

    if (email.isEmpty) {
      valid = false;
      _errors[RegisterForm.EMAIL] = 'Email cannot be empty';
      notifyListeners();
    }

    if (password.isEmpty) {
      valid = false;
      _errors[RegisterForm.PASSWORD] = 'Password cannot be empty';
      notifyListeners();
    }

    if (password.isNotEmpty) {
      if (password.length <= 8) {
        valid = false;
        _errors[RegisterForm.PASSWORD] =
            'Password cannot be less than 8 character';
        notifyListeners();
      } else if (!password.contains(RegExp(r'[0-9]'))) {
        valid = false;
        _errors[RegisterForm.PASSWORD] = 'Password must contain number';
        notifyListeners();
      }
    }

    if (email.isNotEmpty) {
      if (regex.hasMatch(email) == false) {
        valid = false;
        _errors[RegisterForm.EMAIL] = 'Invalid email';
        notifyListeners();
      }
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

  doRegister(BuildContext context) {
    if (validate()) {
      if (storage.hasData(kAuthToken)) {
        var authData = jsonDecode(storage.read(kAuthToken));

        if (authData != null && authData.isNotEmpty) {
          notifyListeners();
          for (var element in authData) {
            if (element['email'] == form.email) {
              showSnackBar('Email is already taken');
            } else {
              var listAuth = [];
              listAuth.add(form.register());
              storage.write(kAuthToken, jsonEncode(listAuth)).then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, loginRoute, (route) => false);
              });
            }
          }
        }
      } else {
        var listAuth = [];
        listAuth.add(form.register());
        storage.write(kAuthToken, jsonEncode(listAuth)).then((value) {
          form.clearData();
          notifyListeners();
          Navigator.pushNamedAndRemoveUntil(
              context, loginRoute, (route) => false);
        });
      }
    }
  }
}
