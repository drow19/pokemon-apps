import 'package:dio/dio.dart';
import 'package:pokedex/model/filter_type_res.dart';
import 'package:pokedex/model/pokemon_detail_res.dart';
import 'package:pokedex/model/pokemon_flavour_text_res.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/model/pokemon_type_res.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/network/error_res.dart';

class PokemonRepository {
  late Dio _dio;

  PokemonRepository() {
    BaseOptions options = BaseOptions(
        baseUrl: kBaseUrl,
        receiveTimeout: Duration(seconds: 15000),
        connectTimeout: Duration(seconds: kConnectionTimeout));
    _dio = Dio(options);
    // _dio.interceptors.add(LoggingInterceptor());
  }

  Future<PokemonRes> getPokemon({int page = 0}) async {
    var params = {'offset': '$page', 'limit': '5'};

    try {
      final response = await _dio.get('/pokemon', queryParameters: params);

      return PokemonRes.fromJson(response.data);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }

  Future<PokemonDetailRes> getPokemonDetail(String name) async {
    try {
      final response = await _dio.get('/pokemon/$name');

      return PokemonDetailRes.fromJson(response.data);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }

  Future<FlavorTextRes> getPokemonDescription(String name) async {
    try {
      final response = await _dio.get('/pokemon-species/$name');

      return FlavorTextRes.fromJson(response.data);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }

  Future<FilterTypeRes> getFilterType() async {
    try {
      final response = await _dio.get('/type');

      return FilterTypeRes.fromJson(response.data);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }

  Future<PokemonTypeRes> getPokemonFilter(String type) async {
    try {
      final response = await _dio.get('/type/$type');

      return PokemonTypeRes.fromJson(response.data);
    } catch (e, s) {
      return Future.error(ErrorRes(e.toString()));
    }
  }
}
