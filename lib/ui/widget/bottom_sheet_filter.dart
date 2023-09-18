import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/main_page/content/home/provider/home_provider.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';
import 'package:provider/provider.dart';

class BottomSheetFilterType extends StatelessWidget {
  const BottomSheetFilterType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Consumer<HomeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.isLoadingType == true) {
            return Container();
          }

          return ListView.builder(
            itemCount: value.listFilter.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  var url = value.listFilter[index].url;
                  var name = value.listFilter[index].name!
                      .capitalizeFirst;
                  var length = value.listFilter[index].url!.length;
                  var replace = url!.replaceRange(length - 1, length, '');
                  var split = replace.split('/');

                  value.filter = {
                    'type': split.last,
                    'name': name,
                  };

                  Navigator.pop(context, value.filter);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2,
                      ),
                      child: Text(
                        value.listFilter[index].name!,
                        style: kTextPoppinsReg12,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
