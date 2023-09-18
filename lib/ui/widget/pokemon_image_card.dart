import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon_detail_res.dart';
import 'package:pokedex/utils/commons/colors.dart';

class PokemonImageCard extends StatelessWidget {
  const PokemonImageCard({Key? key, required this.data}) : super(key: key);

  final PokemonDetailRes data;

  @override
  Widget build(BuildContext context) {
    if(data.name == null){
      return Container();
    }

    return Container(
      height: 110,
      width: 120,
      decoration: BoxDecoration(
        color: cardColor(data.types!.first.type!.name!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Hero(
          tag: '${data.name}-${data.sprites!.other!.home!.frontDefault}',
          child: CachedNetworkImage(
            imageUrl: '${data.sprites!.other!.home!.frontDefault}',
            fit: BoxFit.contain,
            errorWidget: (_, __, ___) => Container(
                height: 110,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
      ),
    );
  }
}
