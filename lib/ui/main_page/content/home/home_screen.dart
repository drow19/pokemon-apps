import 'package:flutter/material.dart';
import 'package:pokedex/ui/main_page/content/home/provider/home_provider.dart';
import 'package:pokedex/ui/widget/bottom_sheet_filter.dart';
import 'package:pokedex/ui/widget/pokemon_Item_card.dart';
import 'package:pokedex/ui/widget/shimmer_loading.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:pokedex/utils/route/routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    var provider = Provider.of<HomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getFilterType();
      provider.getInitData();
    });
  }


  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Consumer<HomeProvider>(
        builder: (BuildContext context, value, Widget? child) => Scaffold(
          body: RefreshIndicator(
            color: kBlueColor1,
            displacement: 10,
            onRefresh: value.onRefresh,
            notificationPredicate: (ScrollNotification scroll) {
              if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                if (value.isLoading == false && value.hasNext == true) {
                  value.page = value.page + 10;
                  value.getInitData();
                }
              }
              return true;
            },
            child: Column(
              children: [
                SizedBox(height: paddingTop),

                //SEARCH BAR
                _SearchBar(),

                //FILTER
                _FilterType(),

                //ITEMS
                Flexible(child: _ListItem()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, value, Widget? child) => Stack(
        children: [
          Container(
            color: kWhiteColor,
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kBlackColor1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_sharp, size: 20),
                  const SizedBox(width: kDefaultPadding / 2),

                  //TEXT FIELD
                  Expanded(
                    child: TextField(
                      controller: value.searchCtrl,
                      style: kTextPoppinsReg12,
                      onSubmitted: (val) {
                        if (val.length >= 3) {
                          value.search = val;
                          value.getSearchPokemon();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Pokemon',
                        hintStyle: kTextPoppinsReg12.copyWith(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: kDefaultPadding,
            bottom: 0,
            child: value.search.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      value.search = '';
                      value.searchCtrl.clear();
                      value.getInitData();
                      value.listData.clear();
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    color: Colors.red,
                    icon: const Icon(Icons.clear),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}

class _FilterType extends StatelessWidget {
  const _FilterType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, value, Widget? child) => InkWell(
        onTap: () async {
          showModalBottomSheet(context: context, builder: (context){
            return BottomSheetFilterType();
          }).then((val){
              if (val != null) {
              if (val['name'] == 'All type') {
                value.listData.clear();
                value.getInitData();
              } else {
                value.getDataFromFilter();
              }
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: cardColor(value.filter['name'] ?? ''),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.filter['name'] ?? 'All type',
                style: kTextPoppinsMed14.copyWith(
                  color: kWhiteColor,
                ),
              ),
              const SizedBox(width: kDefaultPadding / 5),
              const Icon(Icons.arrow_drop_down_outlined, color: kWhiteColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.isLoading == true && value.hasNext == false) {
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            children: List.generate(3, (index) => const ShimmerLoading()),
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
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    detailRoute,
                    arguments: {'data': value.listData[index]},
                  );
                },
                child: PokemonItemCard(data: value.listData[index]));
          },
        );
      },
    );
  }
}
