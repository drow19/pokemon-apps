import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/utils/commons/constan.dart';

class FavoriteProvider extends ChangeNotifier {

  var storage = GetStorage();
  var listData = <PokemonData>[];

  getData(){
    if(storage.hasData(savedItem)){
      String data = storage.read(savedItem);
      List<dynamic> decode = jsonDecode(data) ?? [];
      listData = decode.map((e) => PokemonData.fromJson(e)).toList();
      notifyListeners();
    }
  }
}