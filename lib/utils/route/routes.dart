import 'package:flutter/material.dart';
import 'package:pokedex/ui/auth/login/login.dart';
import 'package:pokedex/ui/auth/register/register_screen.dart';
import 'package:pokedex/ui/main_page/main_page_screen.dart';
import 'package:pokedex/ui/pokemon_detail/pokemon_detail_screen.dart';

const loginRoute = '/login';
const registerRoute = '/register';
const homeRoute = '/';
const detailRoute = '/pokemon/detail';

final Map<String, WidgetBuilder> routes = {
  loginRoute: (BuildContext context) => const LoginScreen(),
  registerRoute: (BuildContext context) => const RegisterScreen(),
  homeRoute: (BuildContext context) => const MainPageScreen(),
  detailRoute: (BuildContext context) => const PokemonDetailScreen(),
};
