import 'package:pokedex/model/pokemon_detail_res.dart';
import 'package:pokedex/model/pokemon_flavour_text_res.dart';

class PokemonRes {
  int? count;
  String? next;
  String? previous;
  List<PokemonData>? results;

  PokemonRes({this.count, this.next, this.previous, this.results});

  PokemonRes.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <PokemonData>[];
      json['results'].forEach((v) {
        results!.add(PokemonData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PokemonData {
  String? name;
  String? url;
  bool? isLoadingType;
  PokemonDetailRes? detail;
  FlavorTextRes? textRes;

  PokemonData({
    this.name,
    this.url,
    this.isLoadingType,
    this.detail,
    this.textRes,
  });

  PokemonData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    if(json['description'] != null){
      textRes = FlavorTextRes.fromJson(json['description']);
    }
    if(json['detail'] != null){
      detail = PokemonDetailRes.fromJson(json['detail']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['detail'] = detail!.toJson();
    data['description'] = textRes!.toJson();
    return data;
  }
}
