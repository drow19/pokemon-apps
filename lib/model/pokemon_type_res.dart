class PokemonTypeRes {
  List<Pokemon>? pokemon;

  PokemonTypeRes({this.pokemon});

  PokemonTypeRes.fromJson(Map<String, dynamic> json) {
    if (json['pokemon'] != null) {
      pokemon = <Pokemon>[];
      json['pokemon'].forEach((v) {
        pokemon!.add(Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pokemon != null) {
      data['pokemon'] = pokemon!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pokemon {
  PokemonName? pokemon;
  int? slot;

  Pokemon({this.pokemon, this.slot});

  Pokemon.fromJson(Map<String, dynamic> json) {
    pokemon =
        json['pokemon'] != null ? PokemonName.fromJson(json['pokemon']) : null;
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pokemon != null) {
      data['pokemon'] = pokemon!.toJson();
    }
    data['slot'] = slot;
    return data;
  }
}

class PokemonName {
  String? name;
  String? url;

  PokemonName({this.name, this.url});

  PokemonName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
