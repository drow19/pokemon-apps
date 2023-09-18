import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';

class ProfileProvider extends ChangeNotifier {
  var storage = GetStorage();

  var userName = '';
  var email = '';
  var password = '';

  getDataProfile() {
    var lastLogin = '';
    if (storage.hasData(kLastLogin)) {
      lastLogin = storage.read(kLastLogin);
    }

    if (storage.hasData(kAuthToken)) {
      List data = jsonDecode(storage.read(kAuthToken));

      for (var element in data) {
        if (element['email'] == lastLogin) {
          userName = element['username'];
          password = element['password'];
          email = element['email'];
        }
      }
    }

    notifyListeners();
  }

  doLogout(BuildContext context) {
    if (storage.hasData(kLastLogin)) {
      notifyListeners();
      storage.remove(kLastLogin).then((value) {
        Navigator.pushNamedAndRemoveUntil(
            context, loginRoute, (route) => false);
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
    }
  }
}
