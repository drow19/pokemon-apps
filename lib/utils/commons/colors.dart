import 'package:flutter/material.dart';

const MaterialColor kMaterialPrimaryDark = MaterialColor(
  0xFF00306B,
  <int, Color>{
    50: Color(0xFF002b60), //10%
    100: Color(0xFF002656), //20%
    200: Color(0xFF00224b), //30%
    300: Color(0xFF001d40), //40%
    400: Color(0xFF001836), //50%
    500: Color(0xFF00132b), //60%
    600: Color(0xFF000e20), //70%
    700: Color(0xFF000a15), //80%
    800: Color(0xFF00050b), //90%
    900: Color(0xFF000000), //100%
  },
);
const MaterialColor kMaterialPrimaryLight = MaterialColor(
  0xFF00306B,
  <int, Color>{
    50: Color(0xFF1a457a), //10%
    100: Color(0xFF335989), //20%
    200: Color(0xFF4d6e97), //30%
    300: Color(0xFF6683a6), //40%
    400: Color(0xFF8098b5), //50%
    500: Color(0xFF99acc4), //60%
    600: Color(0xFFb3c1d3), //70%
    700: Color(0xFFccd6e1), //80%
    800: Color(0xFFe6eaf0), //90%
    900: Color(0xFFffffff), //100%
  },
);

const kColorBlack = Color(0xFF000000);
const kWhiteColor = Color(0xFFffffff);
const kBlackColor1 = Color(0xff333333);
const kBlueColor1 = Color(0xff173EA5);
const kRedColor1 = Color(0xffCD3131);

//POKEMON COLOR TYPE
const allTypeColor = Color(0xff333333);
const waterColor = Color(0xff5090D6);
const dragonColor = Color(0xff0B6DC3);
const electricColor = Color(0xffF4D23C);
const fairyColor = Color(0xffEC8FE6);
const ghostColor = Color(0xff5269AD);
const fireColor = Color(0xffFF9D55);
const iceColor = Color(0xff73CEC0);
const grassColor = Color(0xff63BC5A);
const bugColor = Color(0xff91C12F);
const fightingColor = Color(0xffCE416B);
const normalColor = Color(0xff919AA2);
const darkColor = Color(0xff5A5465);
const steelColor = Color(0xff5A8EA2);
const groundColor = Color(0xffC5B78C);
const physicColor = Color(0xffFA7179);
const rockColor = Color(0xffD97845);
const poisonColor = Color(0xffB567CE);
const flyingColor = Color(0xff89AAE3);

Color cardColor(String type) {
  switch(type.toLowerCase()){
    case 'alltype':
      return allTypeColor;
    case 'water':
      return waterColor;
    case 'dragon':
      return dragonColor;
    case 'electric':
      return electricColor;
    case 'fairy':
      return fairyColor;
    case 'ghost':
      return ghostColor;
    case 'fire':
      return fireColor;
    case 'ice':
      return iceColor;
    case 'grass':
      return grassColor;
    case 'bug':
      return bugColor;
    case 'fighting':
      return fightingColor;
    case 'normal':
      return normalColor;
    case 'dark':
      return darkColor;
    case 'steel':
      return steelColor;
    case 'ground':
      return groundColor;
    case 'physic':
      return physicColor;
    case 'rock':
      return rockColor;
    case 'poison':
      return poisonColor;
    case 'flying':
      return flyingColor;
  }
  return allTypeColor;
}