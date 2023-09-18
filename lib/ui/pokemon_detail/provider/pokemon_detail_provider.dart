import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/utils/commons/constan.dart';

class PokemonDetailProvider extends ChangeNotifier {

  var storage = GetStorage();
  var isExist = false;

  bool isDataExist(PokemonData data){
    String _data = storage.read(savedItem) ?? '';
    List<PokemonData> pokemonData = [];
    if(_data.isNotEmpty){
      List<dynamic> json = jsonDecode(_data) ?? [];
      pokemonData = json.map((e) => PokemonData.fromJson(e)).toList();

      var find = pokemonData.where((element) {
        return element.name == data.name;
      }).toList();

      if(find.isNotEmpty){
        return true;
      }else{
        return false;
      }
    }

    return false;
  }
}