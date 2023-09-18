import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/ui/auth/login/provider/login_provider.dart';
import 'package:pokedex/ui/auth/register/provider/register_provider.dart';
import 'package:pokedex/ui/main_page/content/favorite/provider/favorite_provider.dart';
import 'package:pokedex/ui/main_page/content/home/provider/home_provider.dart';
import 'package:pokedex/ui/main_page/content/profile/provider/profile_provider.dart';
import 'package:pokedex/ui/main_page/provider/main_page_provider.dart';
import 'package:pokedex/ui/pokemon_detail/provider/pokemon_detail_provider.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var route = '';
    if(storage.hasData(kLastLogin)){
      route = homeRoute;
    }else{
      route = loginRoute;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => MainPageProvider()),
        ChangeNotifierProvider(create: (_) => PokemonDetailProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        theme: ThemeData(
          primarySwatch: createMaterialColor(kBlueColor1),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: route,
      ),
    );
  }
}
