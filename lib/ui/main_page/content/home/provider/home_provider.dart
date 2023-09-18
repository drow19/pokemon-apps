import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/model/filter_type_res.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/repository/pokemon_provider.dart';
import 'package:pokedex/ui/widget/snackbar.dart';
import 'package:pokedex/utils/commons/constan.dart';

class HomeProvider extends ChangeNotifier {
  final _provider = new PokemonRepository();

  var searchCtrl = TextEditingController();

  var storage = GetStorage();

  var isLoading = false;
  var isLoadingType = false;
  final isFavorite = false;

  var listData = <PokemonData>[];
  var listFilter = <ResultsType>[];

  var page = 0;
  var hasNext = false;
  var search = '';
  var filter = {};

  getInitData() {
    isLoading = true;
    notifyListeners();

    _provider.getPokemon(page: page).then((value) {
      isLoading = false;
      if (value.results != null || value.results!.isNotEmpty) {
        if (value.results != null) {
          listData.addAll(value.results!);
        }

        if (value.next != null) {
          hasNext = true;
        } else {
          hasNext = false;
        }

        for (var element in listData) {
          var index = listData.indexOf(element);
          getPokemonDetail(element.name!, index);
          getPokemonDescription(element.name!, index);
        }
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      showSnackBar('Something went wrong! Please, try again later');
      notifyListeners();
    });
  }

  getFilterType() {
    isLoadingType = true;
    notifyListeners();

    _provider.getFilterType().then((value) {
      isLoadingType = false;
      if (value.results != null) {
        listFilter = value.results!;
        listFilter.insert(0, ResultsType(name: 'All type', url: ''));
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoadingType = false;
      showSnackBar('Something went wrong! Please, try again later');
      notifyListeners();
    });
  }

  getSearchPokemon() {
    listData.clear();
    listData.add(PokemonData());
    notifyListeners();

    _provider.getPokemonDetail(search).then((value) {
      if (value.name != null && value.name!.isNotEmpty) {
        listData.first.name = search;
        listData.first.detail = value;
        getPokemonDescription(search, 0);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      listData.first.isLoadingType = false;
      print(error.toString());
      showSnackBar('Something went wrong! Please, try again later');
      notifyListeners();
    });
  }

  getPokemonDetail(String name, int index) {
    listData[index].isLoadingType = true;
    notifyListeners();

    _provider.getPokemonDetail(name).then((value) {
      listData[index].isLoadingType = false;
      if (value.name != null && value.name!.isNotEmpty) {
        listData[index].detail = value;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      listData[index].isLoadingType = false;
      showSnackBar('Something went wrong! Please, try again later');
      notifyListeners();
    });
  }

  getPokemonDescription(String name, int index) {
    listData[index].isLoadingType = true;
    notifyListeners();

    _provider.getPokemonDescription(name).then((value) {
      listData[index].isLoadingType = false;
      if (value.flavorTextEntries != null &&
          value.flavorTextEntries!.isNotEmpty) {
        listData[index].textRes = value;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      listData[index].isLoadingType = false;
      notifyListeners();
    });
  }

  getDataFromFilter() {
    listData.clear();
    isLoading = true;
    notifyListeners();

    _provider.getPokemonFilter(filter['type']).then((value) {
      isLoading = false;
      if (value.pokemon != null || value.pokemon!.isNotEmpty) {
        for (var element in value.pokemon!) {
          var index = value.pokemon!.indexOf(element);
          listData.add(PokemonData(
            name: element.pokemon!.name,
            url: element.pokemon!.url,
          ));
          getPokemonDetail(element.pokemon!.name!, index);
          getPokemonDescription(element.pokemon!.name!, index);
        }
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> onRefresh() async {
    page = 0;
    listData.clear();
    getInitData();
    search = '';
    searchCtrl.clear();
    notifyListeners();
  }

  addToFavorite(PokemonData data) {
    String _data = storage.read(savedItem) ?? '';
    List<PokemonData> pokemonData = [];
    if (_data.isNotEmpty) {
      List<dynamic> json = jsonDecode(_data) ?? [];
      pokemonData = json.map((e) => PokemonData.fromJson(e)).toList();

      var find = pokemonData.where((element) {
        return element.name == data.name;
      });

      if (find.isNotEmpty) {
        pokemonData.removeWhere((element) {
          return element.name == data.name;
        });
      } else {
        pokemonData.add(data);
      }
      List<dynamic> encode = pokemonData.map((e) => e.toJson()).toList();
      storage.write(savedItem, jsonEncode(encode));
    } else {
      pokemonData.add(data);
      List<dynamic> encode = pokemonData.map((e) => e.toJson()).toList();
      storage.write(savedItem, jsonEncode(encode));
    }
    notifyListeners();
  }

  bool isDataExist(PokemonData data) {
    String _data = storage.read(savedItem) ?? '';
    List<PokemonData> pokemonData = [];
    if (_data.isNotEmpty) {
      List<dynamic> json = jsonDecode(_data) ?? [];
      pokemonData = json.map((e) => PokemonData.fromJson(e)).toList();

      var find = pokemonData.where((element) {
        return element.name == data.name;
      });

      if (find.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }
}
