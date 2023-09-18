import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon_res.dart';
import 'package:pokedex/ui/main_page/content/home/provider/home_provider.dart';
import 'package:pokedex/ui/pokemon_detail/provider/pokemon_detail_provider.dart';
import 'package:pokedex/ui/widget/pokemon_type_card.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:provider/provider.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    var data = arguments['data'] as PokemonData;

    return Consumer<PokemonDetailProvider>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        backgroundColor: kWhiteColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            //CONTAINER TOP
            Stack(
              children: [
                Container(
                  height: height / 3,
                  decoration: BoxDecoration(
                    color: cardColor(data.detail!.types!.first.type!.name!),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(150),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Hero(
                      tag:
                          '${data.name}-${data.detail!.sprites!.other!.home!.frontDefault!}',
                      child: Image.network(
                        data.detail!.sprites!.other!.home!.frontDefault!,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: kDefaultPadding / 2,
                  top: kDefaultPadding * 1.5,
                  right: kDefaultPadding / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: kWhiteColor,
                        ),
                      ),
                      Consumer<HomeProvider>(
                        builder: (BuildContext context, val, Widget? child) =>
                            IconButton(
                          onPressed: () {
                            Provider.of<HomeProvider>(context, listen: false)
                                .addToFavorite(data);
                          },
                          icon: val.isDataExist(data)
                              ? const Icon(
                                  Icons.favorite,
                                  color: kWhiteColor,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: kWhiteColor,
                                  size: 30,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //DETAIL
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //NAME
                  Text(
                    data.name!,
                    style: kTextPoppinsMed14.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),

                  //GAME INDEX
                  Text(
                    'Nº0${data.detail!.gameIndices!.last.gameIndex}',
                    style: kTextPoppinsMed14,
                  ),
                  const SizedBox(height: kDefaultPadding),

                  //TYPE
                  PokemonTypeCard(data: data.detail!),
                  const SizedBox(height: kDefaultPadding / 2),

                  //ABILITY
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      '${data.textRes!.flavorTextEntries!.first.flavorText}',
                      style: kTextPoppinsMed14,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Divider(),

                  GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 60,
                            mainAxisSpacing: 10),
                    children: data.detail!.stats!.map((e) {
                      if (e.stat!.name == 'hp' ||
                          e.stat!.name == 'attack' ||
                          e.stat!.name == 'defense' ||
                          e.stat!.name == 'special-attack') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.stat!.name!.toUpperCase(),
                              style: kTextPoppinsReg12.copyWith(fontSize: 11),
                            ),
                            const SizedBox(height: kDefaultPadding / 5),
                            Container(
                              // width: 100,
                              padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 2,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey[500]!.withOpacity(.2),
                                ),
                              ),
                              child: Text('${e.baseStat}'),
                            ),
                          ],
                        );
                      }

                      return Container();
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
