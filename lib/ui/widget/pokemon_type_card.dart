import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/model/pokemon_detail_res.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';

class PokemonTypeCard extends StatelessWidget {
  const PokemonTypeCard({Key? key, required this.data}) : super(key: key);

  final PokemonDetailRes data;

  @override
  Widget build(BuildContext context) {
    if(data.name == null){
      return Container();
    }

    return Wrap(
      spacing: 6,
      children: data.types!.map((e) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
          vertical: kDefaultPadding / 5,
        ),
        decoration: BoxDecoration(
          color: cardColor(e.type!.name!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${e.type!.name}'.capitalizeFirst!,
          style: kTextPoppinsMed12.copyWith(
            fontSize: 11,
            color: kBlackColor1,
          ),
        ),
      )).toList(),
    );
  }
}
