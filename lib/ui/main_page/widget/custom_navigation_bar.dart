import 'package:flutter/material.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/commons/constan.dart';

class CustomBottomAppBarItem {
  final dynamic iconData;
  final String? title;

  CustomBottomAppBarItem({this.iconData, @required this.title});
}

class CustomBottomNavAppBar extends StatelessWidget {
  const CustomBottomNavAppBar({
    Key? key,
    @required this.items,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.selectedColor = kWhiteColor,
    this.selectedIndex = 0,
    required this.color,
    required this.onTabSelected,
  }) : super(key: key);

  final List<CustomBottomAppBarItem>? items;
  final double height;
  final double iconSize;
  final Color color;
  final Color selectedColor;
  final Function(int) onTabSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: kWhiteColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items!.length, (index) {
          var item = items![index];
          var color = index == selectedIndex ? kBlueColor1 : Colors.grey;
          return MenuItem(
            icon: item.iconData,
            title: item.title!,
            color: color,
            height: height,
            iconSize: iconSize,
            selected: index == selectedIndex ? true : false,
            onPressed: () {
              onTabSelected(index);
            },
          );
        }),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    @required this.icon,
    @required this.title,
    this.height = 60,
    @required this.onPressed,
    this.iconSize = 24,
    this.color = kBlueColor1,
    this.selected = false,
  }) : super(key: key);

  final dynamic icon;
  final String? title;
  final Color? color;
  final bool? selected;
  final double? height, iconSize;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //IF ICON TYPE ICON DATA
              if (icon != null && icon is IconData) ...[
                Icon(
                  icon,
                  color: color,
                  size: iconSize,
                ),
              ] else if (icon != null && icon is String) ...[
                Image.asset(
                  icon,
                  color: color,
                  width: iconSize,
                  height: iconSize,
                ),
              ] else ...[
                Icon(
                  Icons.build_circle_sharp,
                  color: color,
                  size: iconSize,
                ),
              ],
              const SizedBox(height: kDefaultPadding / 4),
              Text(
                title!,
                style: selected!
                    ? kTextPoppinsReg12.copyWith(color: color)
                    : kTextPoppinsReg12.copyWith(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
