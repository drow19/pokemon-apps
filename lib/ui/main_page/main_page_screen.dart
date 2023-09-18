import 'package:flutter/material.dart';
import 'package:pokedex/ui/main_page/provider/main_page_provider.dart';
import 'package:pokedex/ui/main_page/widget/custom_navigation_bar.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:provider/provider.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        body: value.getContentBody(),
        bottomNavigationBar: CustomBottomNavAppBar(
          color: kWhiteColor,
          selectedColor: kBlueColor1,
          onTabSelected: value.selectedMenu,
          selectedIndex: value.currentMenu,
          items: value.listMenu
              .map((menu) => CustomBottomAppBarItem(
              title: value.titleMenu(menu),
              iconData: value.iconMenu(menu)))
              .toList(),
        ),
      ),
    );
  }
}
