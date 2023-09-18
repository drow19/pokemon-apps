import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pokedex/ui/main_page/content/favorite/provider/favorite_provider.dart';
import 'package:pokedex/ui/main_page/content/home/provider/home_provider.dart';
import 'package:pokedex/ui/widget/pokemon_Item_card.dart';
import 'package:pokedex/ui/widget/shimmer_loading.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    super.initState();

    var provider = Provider.of<FavoriteProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            value.getData();
          },
          child: ListView(
            children: [
              _ContentBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentBody extends StatelessWidget {
  const _ContentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Consumer<FavoriteProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.listData.isEmpty) {
          return SizedBox(
            height: height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(pokeball, height: 100, width: 100),
                const SizedBox(height: kDefaultPadding),
                const Text('Pokeball is empty', style: kTextPoppinsMed16),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: value.listData.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding,
          ),
          itemBuilder: (context, index) {
            if (value.listData[index].detail == null) {
              return const ShimmerLoading();
            }

            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailRoute,
                  arguments: {'data': value.listData[index]},
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Slidable(
                  key: const ValueKey(0),
                  direction: Axis.horizontal,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Provider.of<HomeProvider>(context, listen: false).addToFavorite(value.listData[index]);
                          value.getData();
                        },
                        backgroundColor: cardColor(
                          value
                              .listData[index].detail!.types!.first.type!.name!,
                        ).withOpacity(.5),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: PokemonItemCard(data: value.listData[index]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
